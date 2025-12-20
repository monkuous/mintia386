#pragma once

void memset(unsigned long word, unsigned long size, void *dest) asm("_df_memset");
void memcpy(unsigned long size, const void *src, void *dest) asm("_df_memcpy");
void memmove(unsigned long size, const void *src, void *dest) asm("_df_memmove");

#define STAGE_THREAD 2

struct HALPCIDevice {
    unsigned short Vendor;
    unsigned short Device;
    unsigned short Class;
    unsigned char Revision;
    unsigned char Bus;
    unsigned char Slot;
    unsigned char Function;
};

typedef void (*HALPCICallbackF)(struct HALPCIDevice *device);

unsigned long HALPCIEnumerate(unsigned long interface, unsigned long classCode, unsigned long revision,
    unsigned long devid, unsigned long vendor, HALPCICallbackF func);

void HALLog(const char *src, const char *fmt, unsigned long argc, unsigned long *argv);

#define HALLog(src, fmt, ...)                                                    \
    ({                                                                           \
        unsigned long _dfs_argv[] = {__VA_ARGS__};                               \
        HALLog((src), (fmt), sizeof(_dfs_argv) / sizeof(*_dfs_argv), _dfs_argv); \
    })

#define PCICOMMAND 0x04
#define PCICOMMANDIO 0x0001
#define PCICOMMANDMEM 0x0002
#define PCICOMMANDDMA 0x0004
#define PCICOMMANDNIRQ 0x0400

struct {
    unsigned long irq;
    unsigned long ok;
} HALPCIGetInterrupt(struct HALPCIDevice *device);

struct {
    unsigned long phyaddr;
    unsigned long size;
    unsigned long ok;
} HALPCIGetMemoryBAR(unsigned long idx, struct HALPCIDevice *device);

unsigned long HALPCIReadb(unsigned long offset, struct HALPCIDevice *device);
unsigned long HALPCIReadi(unsigned long offset, struct HALPCIDevice *device);
unsigned long HALPCIReadl(unsigned long offset, struct HALPCIDevice *device);

void HALPCIWriteb(unsigned long value, unsigned long offset, struct HALPCIDevice *device);
void HALPCIWritei(unsigned long value, unsigned long offset, struct HALPCIDevice *device);
void HALPCIWritel(unsigned long value, unsigned long offset, struct HALPCIDevice *device);

struct OSContext;

typedef void (*HALInterruptHandler)(unsigned long irq, struct OSContext *trapframe);

#define IPLHIGH 31
#define IPLCLOCK 29

#define IPLDMA 8
#define IPLDISK 7
#define IPLSERIAL 6
#define IPLBOARDS 5
#define IPLINTERACTIVE 4

#define IPLDPC 2
#define IPLAPC 1
#define IPLLOW 0

void HALInterruptRegister(unsigned long ipl, unsigned long irq, HALInterruptHandler handler);
void HALInterruptUnregister(unsigned long irq);

#define MMIO_NOCACHE 0
#define MMIO_CACHED 1
#define MMIO_WRITECOMBINE 2

struct {
    unsigned long vaddr;
    unsigned long ok;
} MmIORegionMap(unsigned long phyaddr, unsigned long length, unsigned long cached);
void MmIORegionUnmap(unsigned long vaddr, unsigned long length);

#define ZEROMUST 1
#define FREEFIRST 2

#define MUSTSUCCEED 0x8000
#define CANBLOCK 0x10000
#define MUSTSUCCEEDL2 0x40000
#define SYSTEMSPACE 0x80000
#define POOLALLOC 0x100000
#define PAGED 0x200000 // implies CANBLOCK
#define POOLEXP 0x400000

#define PRIVALLOC (MUSTSUCCEED | MUSTSUCCEEDL2 | POOLALLOC)

struct {
    void *ptr;
    unsigned long ok;
} MmAllocWithTag(unsigned long flags, unsigned long tag, unsigned long bytes);
void MmFree(void *ptr);

struct KeTime {
    unsigned long SecPart;
    unsigned long MsPart;
};

void HALUptimeQuery(struct KeTime *time);

#define STATUS_SUCCESS (0UL)
#define STATUS_MINUS_ONE (-1UL) // reserved
#define STATUS_NO_MEMORY (-2UL)
#define STATUS_QUOTA_EXCEEDED (-3UL)
#define STATUS_KERNEL_APC (-4UL)
#define STATUS_USER_APC (-5UL)
#define STATUS_WAIT_TIMEOUT (-6UL)
#define STATUS_INVALID_HANDLE (-7UL)
#define STATUS_DEADLOCK_POSSIBLE (-8UL)
#define STATUS_INVALID_ARGUMENT (-9UL)
#define STATUS_INVALID_OBJECT_TYPE (-10UL)
#define STATUS_NO_SUCH_USER (-11UL)
#define STATUS_PERMISSION_DENIED (-12UL)
#define STATUS_SIGNALLED (-13UL)
#define STATUS_KILLED (-14UL)
#define STATUS_FORBIDDEN_OPERATION (-15UL)
#define STATUS_NAME_TOO_LONG (-16UL)
#define STATUS_NOT_A_DIRECTORY (-17UL)
#define STATUS_NOT_FOUND (-18UL)
#define STATUS_NOT_SUPPORTED (-19UL)
#define STATUS_BUFFER_MAXIMUM (-20UL)
#define STATUS_NOT_AVAILABLE (-21UL)
#define STATUS_IS_A_DIRECTORY (-22UL)
#define STATUS_END_OF_DISK (-23UL)
#define STATUS_END_OF_FILE (-24UL)
#define STATUS_TRY_AGAIN_LATER (-25UL)
#define STATUS_DEVICE_BUSY (-26UL)
#define STATUS_BAD_FILESYSTEM (-27UL)
#define STATUS_NO_SUCH_FILESYSTEM (-28UL)
#define STATUS_READONLY_FILESYSTEM (-29UL)
#define STATUS_UNAVAILABLE_ADDRESS (-30UL)
#define STATUS_OVERFLOW (-31UL)
#define STATUS_BAD_ADDRESS (-32UL)
#define STATUS_FAULT (-33UL)
#define STATUS_NOT_IMPLEMENTED (-34UL)
#define STATUS_NOT_CORRECT_FILETYPE (-35UL)
#define STATUS_UNALIGNED (-36UL)
#define STATUS_VM_QUOTA_EXCEEDED (-37UL)
#define STATUS_BAD_EXECUTABLE (-38UL)
#define STATUS_EXEC_NOT_FOR_ARCH (-39UL)
#define STATUS_NO_SYMBOL (-40UL)
#define STATUS_SWAP_TOO_SMALL (-41UL)
#define STATUS_NO_SWAP (-42UL)
#define STATUS_RING_FULL (-43UL)
#define STATUS_RING_EMPTY (-44UL)
#define STATUS_PAGED_QUOTA_EXCEEDED (-45UL)
#define STATUS_MUTEX_NOT_OWNED (-46UL)
#define STATUS_CONSOLE_HUNG_UP (-47UL)
#define STATUS_PROCESS_IS_TERMINATED (-48UL)
#define STATUS_ALIVE (-49UL)
#define STATUS_ARGUMENTS_TOO_LONG (-50UL)
#define STATUS_PROCESS_NO_THREAD (-51UL)
#define STATUS_ENVIRON_NOT_FOUND (-52UL)
#define STATUS_ENVIRON_TOO_LARGE (-53UL)
#define STATUS_NOT_A_FILE (-54UL)
#define STATUS_COMMIT_EXCEEDED (-55UL)
#define STATUS_NO_CONSOLE (-56UL)
#define STATUS_HAS_CONSOLE (-57UL)
#define STATUS_ILLEGAL_NAME (-58UL)
#define STATUS_ALREADY_EXISTS (-59UL)
#define STATUS_FAULT_WHILE_STARTING (-60UL)
#define STATUS_CROSS_VOLUME (-61UL)
#define STATUS_NOT_A_SIGNAL (-62UL)
#define STATUS_INVALID_CONFIG_FILE (-63UL)
#define STATUS_NO_SUCH_GROUP (-64UL)
#define STATUS_NOT_A_CONSOLE (-65UL)
#define STATUS_OVERLAPS_MMIO (-66UL)
#define STATUS_PHYSICAL_COMMIT_EXCEEDED (-67UL)
#define STATUS_TOO_MANY_PAGEFILES (-68UL)
#define STATUS_ALREADY_ENQUEUED (-69UL)
#define STATUS_NOT_ENQUEUED (-70UL)
#define STATUS_STRIPPED_EXECUTABLE (-71UL)
#define STATUS_OTHER_CONDITION (-72UL)
#define STATUS_IO_CANCELLED (-73UL)
#define STATUS_MESSAGE_TOO_LONG (-74UL)
#define STATUS_WS_QUOTA_EXCEEDED (-75UL)
#define STATUS_NO_MESSAGE (-76UL)
#define STATUS_PORT_DISCONNECTED (-77UL)
#define STATUS_CONNECTION_FAILED (-78UL)
#define STATUS_NO_SUCH_CLIENT (-79UL)
#define STATUS_INCORRECT_PASSWORD (-80UL)
#define STATUS_REFAULT (-81UL)
#define STATUS_FAULT_ERROR (-82UL)
#define STATUS_PASSWORD_TOO_LONG (-83UL)
#define STATUS_PORT_QUEUE_FULL (-84UL)
#define STATUS_IO_CANCEL_INCOMPLETE (-85UL)
#define STATUS_DEAD_SYSTEM (-86UL)
#define STATUS_NOT_MOUNTED (-87UL)
#define STATUS_INVALID_USERNAME (-88UL)
#define STATUS_INVALID_GROUPNAME (-89UL)
#define STATUS_USER_EXISTS (-90UL)
#define STATUS_GROUP_EXISTS (-91UL)
#define STATUS_REPARSE_MAXIMUM (-92UL)
#define STATUS_SYNTAX_ERROR (-93UL)
#define STATUS_IO_ERROR (-94UL)
#define STATUS_JOB_IS_TERMINATED (-95UL)
#define STATUS_PROCESS_HAS_JOB (-96UL)
#define STATUS_PROCESS_NO_JOB (-97UL)
#define STATUS_JOB_DEPTH (-98UL)
#define STATUS_FILE_CORRUPT (-99UL)
#define STATUS_FAULT_WRITE (-100UL)
#define STATUS_FILE_BUSY (-101UL)
#define STATUS_NO_VARIABLE (-102UL)
#define STATUS_MEDIA_REMOVED (-103UL)

#define PAGESIZE 4096UL
#define PAGEOFFSETMASK (PAGESIZE - 1)
#define PAGENUMBERMASK (~PAGEOFFSETMASK)
#define PAGESHIFT 12

unsigned long MmVirtualToPhysical(void *ptr);

struct KeDPC;

typedef void (*KeDPCFunction)(struct KeDPC *dpc, void *context2, void *context1);

struct KeDPC {
    struct KeDPC *Next;
    KeDPCFunction Function;
    void *Context1;
    void *Context2;
    unsigned long Enqueued;
};

#define DPCHIGHIMPORTANCE 1
#define DPCLOWIMPORTANCE 2

void KeDPCInitialize(struct KeDPC *dpc, KeDPCFunction function);
unsigned long KeDPCEnqueue(struct KeDPC *dpc, unsigned long importance, void *context2, void *context1);

_Noreturn void KeCrash(const char *fmt, unsigned long argc, unsigned long *argv);

#define KeCrash(fmt, ...)                                                  \
    ({                                                                     \
        unsigned long _dfs_argv[] = {__VA_ARGS__};                         \
        KeCrash((fmt), sizeof(_dfs_argv) / sizeof(*_dfs_argv), _dfs_argv); \
    })

#define OSEVENT_SYNCH 1
#define OSEVENT_NOTIF 2

struct KeDispatchHeader {
    unsigned long Signaled;

    unsigned long Type;

    struct KeDispatchWaitBlock *WaitBlockListHead;
    struct KeDispatchWaitBlock *WaitBlockListTail;

    const char *Name;
};

struct KeEvent {
    struct KeDispatchHeader DispatchHeader;
};

void KeEventInitialize(struct KeEvent *event, const char *name, unsigned long type, unsigned long signaled);
unsigned long KeEventReset(struct KeEvent *event);
void KeEventSignal(struct KeEvent *event, unsigned long priboost);

#define OSWAIT_TIMEOUTINFINITE (-1UL)
#define KERNELMODE 1

unsigned long KeThreadWaitForObject(struct KeDispatchHeader *object, unsigned long timeout, unsigned long alertable,
    unsigned long waitmode);

unsigned long HALCPUInterruptDisable();
void HALCPUInterruptRestore(unsigned long rs);
