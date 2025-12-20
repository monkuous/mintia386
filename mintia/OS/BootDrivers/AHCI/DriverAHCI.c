//
// Implements the AHCI driver.
//

#include "CKernelBindings.h"

#define Printf(fmt, ...) HALLog("AHCI", fmt, ##__VA_ARGS__)

#define ABAR 5

#define CAP 0x00
#define GHC 0x04
#define IS 0x08
#define PI 0x0c
#define PxCLB 0x100
#define PxCLBU 0x104
#define PxFB 0x108
#define PxFBU 0x10c
#define PxIS 0x110
#define PxIE 0x114
#define PxCMD 0x118
#define PxTFD 0x120
#define PxSIG 0x124
#define PxSSTS 0x128
#define PxSERR 0x130
#define PxCI 0x138

#define PORT_SCALE 0x80

#define CAP_NP(x) (((x) >> 0) & 0x1f)
#define CAP_SSS (1U << 27)

#define GHC_HR (1U << 0)
#define GHC_IE (1U << 1)
#define GHC_AE (1U << 31)

#define PxI_TFE (1U << 30)
#define PxI_HBF (1U << 29)
#define PxI_HBD (1U << 28)
#define PxI_IF (1U << 27)
#define PxI_INF (1U << 26)
#define PxI_OF (1U << 24)
#define PxI_IPM (1U << 23)
#define PxI_PRC (1U << 22)
#define PxI_PC (1U << 6)
#define PxI_UF (1U << 4)
#define PxI_DHR (1U << 0)

#define PxI_ERROR (PxI_TFE | PxI_HBF | PxI_HBD | PxI_IF | PxI_INF | PxI_OF | PxI_IPM | PxI_PRC | PxI_PC | PxI_UF)

#define PxCMD_ST (1U << 0)
#define PxCMD_SUD (1U << 1)
#define PxCMD_POD (1U << 2)
#define PxCMD_FRE (1U << 4)
#define PxCMD_FR (1U << 14)
#define PxCMD_ICC_MASK (15U << 28)
#define PxCMD_ICC_ACTIVE (1U << 28)

#define PxTFD_STS_BSY (1U << 7)

#define PxSIG_ATA 0x101

#define PxSSTS_DET(x) (((x) >> 0) & 0xf)
#define PxSSTS_DET_PRESENT 3

struct AHCIPort;

struct AHCIController {
    volatile void *regs;
    struct AHCIPort *ports;
    unsigned long numPorts;
};

#define AHCI_COMMAND_REGFIS (5U << 0)
#define AHCI_COMMAND_WRITE (1U << 6)
#define AHCI_COMMAND_PREFETCH (1U << 7)

struct AHCICommand {
    unsigned short flags;
    unsigned short prdtCount;
    unsigned int transferredBytes;
    unsigned long long commandTable;
} __attribute__((aligned(32)));

struct PRDTEntry {
    unsigned long long dataBase;
    unsigned int reserved;
    unsigned int count;
};

#define FIS_REGISTER_H2D 0x27
#define FIS_REGISTER_H2D_COMMAND (1U << 7)

#define ATA_COMMAND_IDENTIFY 0xec

struct AHCICommandTable {
    union {
        struct {
            unsigned char type;
            unsigned char flags;
            unsigned char command;
            unsigned char features0;
            unsigned short lba0;
            unsigned char lba1;
            unsigned char device;
            unsigned short lba2;
            unsigned char lba3;
            unsigned char features1;
            unsigned short count;
            unsigned char reserved;
            unsigned char control;
        } reg;
        unsigned char data[64];
    } fis;
    unsigned char acmd[32];
    unsigned char reserved[32];
    struct PRDTEntry prdt[8];
} __attribute__((aligned(128)));

struct ReceivedFIS {
    unsigned char dsfis[0x1c];
    unsigned char reserved0[4];
    unsigned char psfis[0x14];
    unsigned char reserved1[12];
    struct {
        unsigned char type;
        unsigned char flags;
        unsigned char status;
        unsigned char error;
        unsigned short lba0;
        unsigned char lba1;
        unsigned char device;
        unsigned short lba2;
        unsigned char lba3;
        unsigned char reserved0;
        unsigned short count;
        unsigned short reserved1;
        unsigned int reserved2;
    } reg;
    unsigned char reserved2[4];
    unsigned char sdbfis[8];
    unsigned char ufis[64];
    unsigned char reserved3[96];
} __attribute__((aligned(256)));

#define IDENTIFY_VALID_MASK (3U << 14)
#define IDENTIFY_VALID (1U << 14)

#define IDENTIFY_FEATURES0_LBA48 (1U << 26)

#define IDENTIFY_LSS_BLOCK_SIZE_VALID (1U << 12)

#define IDENTIFY_CHECKSUM_MAGIC_MASK 0xff
#define IDENTIFY_CHECKSUM_MAGIC 0xa5

struct AHCIDataPage {
    _Alignas(1024) struct AHCICommand commandList[32];
    struct ReceivedFIS fis;
    struct AHCICommandTable commandTable[9];
    union {
        struct {
            unsigned short padding0[60];
            unsigned int lba28_blocks;
            unsigned short padding1[23];
            unsigned int features0;
            unsigned short features1;
            unsigned short padding2[12];
            unsigned long long lba48_blocks;
            unsigned short padding3[2];
            unsigned short lss;
            unsigned short padding4[10];
            unsigned int blockSize;
            unsigned short padding5[136];
            unsigned short checksum;
        } __attribute__((packed));
        char data[512];
    } identify;
};

_Static_assert(sizeof(struct AHCIDataPage) <= PAGESIZE, "AHCIDataPage too large");

struct AHCIPort {
    struct AHCIController *controller;
    unsigned long index;
    struct AHCIDataPage *data;
    struct KeDPC dpc;
    struct KeEvent event;
    unsigned int pendingCommands;
    unsigned long blocks;
    unsigned long blockSize;
    bool lba48;
};

static struct AHCIController *Controller;

static unsigned int ReadReg(struct AHCIController *controller, unsigned long offset);
static void WriteReg(struct AHCIController *controller, unsigned long offset, unsigned int value);

static unsigned int PortReadReg(struct AHCIPort *port, unsigned long offset) {
    return ReadReg(port->controller, offset + port->index * PORT_SCALE);
}

static void PortWriteReg(struct AHCIPort *port, unsigned long offset, unsigned int value) {
    WriteReg(port->controller, offset + 0x80 * port->index, value);
}

static unsigned long MsElapsed(struct KeTime *time1, struct KeTime *time2) {
    return (time2->SecPart - time1->SecPart) * 1000 - time1->MsPart + time2->MsPart;
}

static void AHCIDPCFunction(struct KeDPC *dpc, void *, void *) {
    struct AHCIPort *port = (void *)dpc - __builtin_offsetof(struct AHCIPort, dpc);
    KeEventSignal(&port->event, 0);
}

static void AHCIInterrupt(unsigned long, struct OSContext *) {
    struct AHCIController *controller = Controller;
    unsigned int status = ReadReg(controller, IS);
    WriteReg(controller, IS, status);

    for (unsigned int i = 0; i < controller->numPorts; i++) {
        struct AHCIPort *port = &controller->ports[i];
        if ((status & (1U << port->index)) == 0) continue;

        unsigned int pstatus = PortReadReg(port, PxIS);
        PortWriteReg(port, PxIS, pstatus);

        if (pstatus & PxI_ERROR) KeCrash("AHCI: error on port %d (0x%x)\n", port->index, pstatus);

        unsigned long pending = PortReadReg(port, PxCI);
        unsigned long completed = port->pendingCommands & ~pending;
        if (!completed) continue;
        port->pendingCommands = pending;

        KeDPCEnqueue(&port->dpc, DPCHIGHIMPORTANCE, nullptr, nullptr);
    }
}

static unsigned long InitializePort(struct AHCIPort *port) {
    PortWriteReg(port, PxCMD, PortReadReg(port, PxCMD) | PxCMD_ST);

    struct KeTime time1, time2;
    HALUptimeQuery(&time1);

    while (PxSSTS_DET(PortReadReg(port, PxSSTS)) != PxSSTS_DET_PRESENT) {
        HALUptimeQuery(&time2);

        if (MsElapsed(&time1, &time2) >= 10) {
            return STATUS_SUCCESS;
        }
    }

    PortWriteReg(port, PxSERR, PortReadReg(port, PxSERR));

    while ((PortReadReg(port, PxTFD) & 0xff) == 0xff);

    unsigned long sig = PortReadReg(port, PxSIG);
    if (sig != PxSIG_ATA) return 0;

    PortWriteReg(port, PxIS, PortReadReg(port, PxIS));
    WriteReg(port->controller, IS, 1U << port->index);
    PortWriteReg(port, PxIE, PxI_ERROR | PxI_DHR | 6);

    // perform identify
    struct AHCICommand *command = port->data->commandList;
    struct AHCICommandTable *ctbl = port->data->commandTable;

    command->flags = AHCI_COMMAND_REGFIS | AHCI_COMMAND_PREFETCH;
    command->prdtCount = 1;
    command->transferredBytes = 0;

    memset(0, sizeof(ctbl->fis), &ctbl->fis);
    ctbl->fis.reg.type = FIS_REGISTER_H2D;
    ctbl->fis.reg.flags = FIS_REGISTER_H2D_COMMAND;
    ctbl->fis.reg.command = ATA_COMMAND_IDENTIFY;

    ctbl->prdt[0].dataBase = MmVirtualToPhysical(&port->data->identify);
    ctbl->prdt[0].count = sizeof(port->data->identify);

    unsigned long rs = HALCPUInterruptDisable();
    port->pendingCommands = 1;
    KeEventReset(&port->event);
    PortWriteReg(port, PxCI, 1);
    HALCPUInterruptRestore(rs);
    KeThreadWaitForObject(&port->event.DispatchHeader, OSWAIT_TIMEOUTINFINITE, 0, KERNELMODE);

    if ((port->data->identify.checksum & IDENTIFY_CHECKSUM_MAGIC_MASK) == IDENTIFY_CHECKSUM_MAGIC) {
        unsigned char sum = 0;

        for (unsigned long i = 0; i < 512; i++) {
            sum += port->data->identify.data[i];
        }

        if (sum != 0) {
            Printf("port %d: IDENTIFY data checksum incorrect\n", port->index);
            return 0;
        }
    }

    if ((port->data->identify.features1 & IDENTIFY_VALID_MASK) == IDENTIFY_VALID &&
        (port->data->identify.features0 & IDENTIFY_FEATURES0_LBA48) != 0) {
        if (port->data->identify.lba48_blocks >> 32) {
            Printf("port %d: truncating size to 0xffffffff blocks\n", port->index);
            port->blocks = -1;
        } else {
            port->blocks = port->data->identify.lba48_blocks;
        }

        port->lba48 = true;
    } else {
        port->blocks = port->data->identify.lba28_blocks;
        port->lba48 = false;
    }

    if (!port->blocks) {
        Printf("port %d: device has 0 length\n", port->index);
        return 0;
    }

    if ((port->data->identify.lss & IDENTIFY_VALID_MASK) == IDENTIFY_VALID &&
        (port->data->identify.lss & IDENTIFY_LSS_BLOCK_SIZE_VALID) != 0) {
        port->blockSize = port->data->identify.blockSize * 2;
    } else {
        port->blockSize = 512;
    }

    Printf("port %d: %d blocks (block size: %d)\n", port->index, port->blocks, port->blockSize);

    return 0;
}

static unsigned long AHCIInitialize(struct HALPCIDevice *device) {
    if (Controller) return STATUS_DEVICE_BUSY;

    auto bar = HALPCIGetMemoryBAR(ABAR, device);
    if (bar.ok) return bar.ok;

    auto irq = HALPCIGetInterrupt(device);
    if (irq.ok) return irq.ok;

    Printf("ABAR @ 0x%x-0x%x, IRQ %d\n", bar.phyaddr, bar.phyaddr + bar.size - 1, irq.irq);

    HALPCIWritei((HALPCIReadi(PCICOMMAND, device) & ~PCICOMMANDNIRQ) | PCICOMMANDMEM | PCICOMMANDDMA, PCICOMMAND,
        device);

    auto alloc = MmAllocWithTag(CANBLOCK, 'AHCI', sizeof(struct AHCIController));
    if (alloc.ok) return alloc.ok;
    struct AHCIController *controller = alloc.ptr;

    auto regs = MmIORegionMap(bar.phyaddr, bar.size, MMIO_NOCACHE);
    if (regs.ok) {
        MmFree(alloc.ptr);
        return regs.ok;
    }
    controller->regs = (volatile void *)regs.vaddr;

    // reset controller
    unsigned long savedCaps = ReadReg(controller, CAP) & (CAP_SSS);
    unsigned long savedPortsMask = ReadReg(controller, PI);

    WriteReg(controller, GHC, (ReadReg(controller, GHC) & ~GHC_IE) | GHC_AE);
    WriteReg(controller, GHC, ReadReg(controller, GHC) | GHC_HR);

    struct KeTime time1, time2;
    HALUptimeQuery(&time1);

    while (ReadReg(controller, GHC) & GHC_HR) {
        HALUptimeQuery(&time2);

        if (MsElapsed(&time1, &time2) >= 1000) {
            MmIORegionUnmap(regs.vaddr, bar.size);
            MmFree(alloc.ptr);
            return STATUS_IO_ERROR;
        }
    }

    WriteReg(controller, GHC, ReadReg(controller, GHC) | GHC_AE);
    WriteReg(controller, CAP, ReadReg(controller, CAP) | savedCaps);
    WriteReg(controller, PI, savedPortsMask);

    // initialize controller
    HALInterruptRegister(IPLDISK, irq.irq, AHCIInterrupt);

    unsigned int capabilities = ReadReg(controller, CAP);
    unsigned int portMap = ReadReg(controller, PI);
    controller->numPorts = 0;

    if (!portMap) {
        portMap = 0xffffffffU >> (31 - CAP_NP(capabilities));
    }

    for (unsigned i = 0; i < 32; i++) {
        if (portMap & (1U << i)) {
            controller->numPorts += 1;
        }
    }

    alloc = MmAllocWithTag(CANBLOCK, 'AHCp', sizeof(struct AHCIPort) * controller->numPorts);
    if (alloc.ok) {
        HALInterruptUnregister(irq.irq);
        MmIORegionUnmap(regs.vaddr, bar.size);
        MmFree(controller);
        return STATUS_IO_ERROR;
    }
    controller->ports = alloc.ptr;

    unsigned int portsInitialized = 0;

    for (unsigned int index = 0; index < 32; index++) {
        if ((portMap & (1U << index)) == 0) continue;
        struct AHCIPort *port = &controller->ports[portsInitialized];

        port->controller = controller;
        port->index = index;

        alloc = MmAllocWithTag(CANBLOCK | ZEROMUST, 'AHCd', PAGESIZE);

        if (alloc.ok) {
            for (unsigned int i = 0; i < portsInitialized; i++) {
                port = &controller->ports[i];

                PortWriteReg(port, PxCMD, PortReadReg(port, PxCMD) & ~PxCMD_FRE);
                while (PortReadReg(port, PxCMD) & PxCMD_FR);

                MmFree(port->data);
            }

            MmFree(controller->ports);
            HALInterruptUnregister(irq.irq);
            MmIORegionUnmap(regs.vaddr, bar.size);
            MmFree(controller);
            return alloc.ok;
        }

        port->data = alloc.ptr;
        port->data->commandList[0].commandTable = MmVirtualToPhysical(&port->data->commandTable[0]);

        PortWriteReg(port, PxCLB, MmVirtualToPhysical(port->data->commandList));
        PortWriteReg(port, PxCLBU, 0);
        PortWriteReg(port, PxFB, MmVirtualToPhysical(&port->data->fis));
        PortWriteReg(port, PxFBU, 0);

        PortWriteReg(port, PxIS, PortReadReg(port, PxIS));
        PortWriteReg(port, PxSERR, PortReadReg(port, PxSERR));

        PortWriteReg(port, PxCMD,
            (PortReadReg(port, PxCMD) & ~PxCMD_ICC_MASK) | PxCMD_POD | PxCMD_SUD | PxCMD_ICC_ACTIVE | PxCMD_FRE);

        KeDPCInitialize(&port->dpc, AHCIDPCFunction);
        KeEventInitialize(&port->event, "AHCICompletionEvent", OSEVENT_SYNCH, 0);

        portsInitialized += 1;
    }

    Printf("initialized %d ports\n", portsInitialized);
    controller->numPorts = portsInitialized;

    WriteReg(controller, IS, ReadReg(controller, IS));

    Controller = controller;
    WriteReg(controller, GHC, ReadReg(controller, GHC) | GHC_IE);

    for (unsigned int i = 0; i < controller->numPorts; i++) {
        unsigned long ok = InitializePort(&controller->ports[i]);

        if (ok != 0) {
            Printf("failed to initialize port %d (%i)\n", controller->ports[i].index, ok);
        }
    }

    return 0;
}

static void AHCICallback(struct HALPCIDevice *device) {
    unsigned long ok = AHCIInitialize(device);

    if (ok) {
        Printf("failed to initialize controller (%i)\n", ok);
    }
}

unsigned long DriverInit(unsigned long stage) {
    if (stage == STAGE_THREAD) {
        HALPCIEnumerate(1, 0x106, -1, -1, -1, AHCICallback);
    }

    return 0;
}

static unsigned int ReadReg(struct AHCIController *controller, unsigned long offset) {
#ifdef __i386
    unsigned int value;
    asm volatile("mov %1, %0" : "=a"(value) : "m"(*(volatile unsigned int *)(controller->regs + offset)) : "memory");
    return value;
#else
    asm volatile("" ::: "memory");
    unsigned int value = *(volatile unsigned int *)(controller->regs + offset);
    asm volatile("" ::: "memory");
    return value;
#endif
}

static void WriteReg(struct AHCIController *controller, unsigned long offset, unsigned int value) {
#ifdef __i386
    asm volatile("mov %0, %1" ::"a"(value), "m"(*(volatile unsigned int *)(controller->regs + offset)) : "memory");
#else
    asm volatile("" ::: "memory");
    *(volatile unsigned int *)(controller->regs + offset) = value;
    asm volatile("" ::: "memory");
#endif
}
