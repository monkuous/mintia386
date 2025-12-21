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

struct IOFile;
struct IOFileControlBlock;
struct OSFileInformation;
struct PsProcess;
struct OSDirectoryEntry;
struct IOPacketHeader;
struct IOPacketLocation;

typedef unsigned long (*IODispatchOpenFunction)(struct IOFile *fileobject, unsigned long access);
typedef unsigned long (
    *IODispatchCloseFunction)(struct IOFile *fileobject, unsigned long access, unsigned long lasthandlecount);
typedef struct IODispatchIOControlFunction {
    unsigned long ret;
    unsigned long ok;
} (*IODispatchIOControlFunction)(unsigned long lastmode, struct IOFileControlBlock *fcb, unsigned long access,
    unsigned long arg1, unsigned long arg2);
typedef unsigned long (*IODispatchSetFileFunction)(struct IOFile *fileobject, struct OSFileInformation *info);
typedef unsigned long (*IODispatchUnlinkFunction)(struct IOFileControlBlock *dirfcb, const char *name);
typedef struct IODispatchParseFunction {
    const char *reparsepath;
    unsigned long ok;
} (*IODispatchParseFunction)(struct PsProcess *process, struct IOFileControlBlock *initialfcb,
    struct IOFile *fileobject);
typedef unsigned long (*IODispatchDeleteObjectFunction)(struct IOFile *object);
typedef unsigned long (*IODispatchPokeFunction)(struct IOFile *object, unsigned long poketype);
typedef unsigned long (*IODispatchSetSecurityFunction)(struct IOFile *object, unsigned long permissions,
    unsigned long gid, unsigned long uid);
typedef unsigned long (*IODispatchRenameFunction)(struct IOFileControlBlock *destfcb, const char *destname,
    struct IOFileControlBlock *srcfcb, const char *srcname);
typedef unsigned long (*IODispatchTruncateFunction)(struct IOFileControlBlock *fcb, unsigned long flags,
    unsigned long zero, unsigned long newsize);
typedef struct IODispatchReadDirectoryFunction {
    unsigned long nextseek;
    unsigned long readcount;
    unsigned long ok;
} (*IODispatchReadDirectoryFunction)(unsigned long lastmode, struct IOFileControlBlock *fcb,
    struct OSDirectoryEntry *dirent, unsigned long seek, unsigned long count);
typedef struct IODispatchGetPageAddressFunction {
    unsigned long phyaddr;
    unsigned long ok;
} (*IODispatchGetPageAddressFunction)(struct IOFileControlBlock *fcb, unsigned long offset);
typedef void (*IODispatchDeleteDeviceObjectFunction)(struct IOFile *object);
typedef unsigned long (*IODispatchCancelFunction)(struct IOPacketHeader *iop);
typedef struct IODispatchEnqueueIOPFunction {
    unsigned long done;
    unsigned long ok;
} (*IODispatchEnqueueIOPFunction)(struct IOPacketLocation *iopl);

struct IODevice;

typedef unsigned long (*IOFilesystemFlushFunction)(struct IODevice *fsdeviceobject, unsigned long shutdown);

struct IODispatchTable {
    IODispatchOpenFunction Open;
    IODispatchCloseFunction Close;
    IODispatchIOControlFunction IOControl;
    IODispatchSetFileFunction SetFile;
    unsigned long Reserved9;
    IODispatchUnlinkFunction Unlink;
    IODispatchParseFunction Parse;
    unsigned long Reserved4;
    IOFilesystemFlushFunction Flush;
    IODispatchDeleteObjectFunction DeleteObject;
    IODispatchPokeFunction Poke;
    IODispatchSetSecurityFunction SetSecurity;
    IODispatchRenameFunction Rename;
    unsigned long Reserved6;
    unsigned long Reserved7;
    IODispatchTruncateFunction Truncate;
    IODispatchReadDirectoryFunction ReadDirectory;
    IODispatchGetPageAddressFunction GetPageAddress;
    IODispatchDeleteDeviceObjectFunction DeleteDeviceObject;
    unsigned long Reserved5;
    IODispatchCancelFunction Cancel;
    IODispatchEnqueueIOPFunction IOPRead;
    IODispatchEnqueueIOPFunction IOPWrite;
};

struct IODriver {
    unsigned long VersionMajor;
    unsigned long VersionMinor;

    const char *Name;
    struct IODispatchTable *DispatchTable;
    unsigned long BlockLog;
    unsigned long Flags;

    unsigned long Reserved1;
    unsigned long Reserved2;
    unsigned long Reserved3;
    unsigned long Reserved4;
    unsigned long Reserved5;
    unsigned long Reserved6;
    unsigned long Reserved7;
};

struct IODevice {
    struct IODriver *Driver;
    void *Extension;
    struct IOFileControlBlock *FileControlBlock;
    unsigned long BlockLog;

    struct IOMount *RelevantMount;
    unsigned long StackDepth;
    unsigned long Flags;
};

#define IOVERSION_MAJOR 1
#define IOVERSION_MINOR 0

unsigned long IODeviceDeleteFileObject(struct IOFile *object);

#define ACCESS_WORLD_EXEC 1
#define ACCESS_WORLD_WRITE 2
#define ACCESS_WORLD_READ 4

#define ACCESS_WORLD_ALL (ACCESS_WORLD_EXEC | ACCESS_WORLD_WRITE | ACCESS_WORLD_READ)

#define ACCESS_GROUP_EXEC 8
#define ACCESS_GROUP_WRITE 16
#define ACCESS_GROUP_READ 32

#define ACCESS_GROUP_ALL (ACCESS_GROUP_EXEC | ACCESS_GROUP_WRITE | ACCESS_GROUP_READ)

#define ACCESS_OWNER_EXEC 64
#define ACCESS_OWNER_WRITE 128
#define ACCESS_OWNER_READ 256

#define ACCESS_OWNER_ALL (ACCESS_OWNER_EXEC | ACCESS_OWNER_WRITE | ACCESS_OWNER_READ)

#define ACCESS_ALL_ALL (ACCESS_WORLD_ALL | ACCESS_GROUP_ALL | ACCESS_OWNER_ALL)

#define ACCESS_ANY_EXEC (ACCESS_WORLD_EXEC | ACCESS_GROUP_EXEC | ACCESS_OWNER_EXEC)

#define OSFILETYPE_ANY 0
#define OSFILETYPE_FILE 1
#define OSFILETYPE_DIRECTORY 2
#define OSFILETYPE_CHARDEVICE 3
#define OSFILETYPE_BLOCKDEVICE 4

struct {
    struct IODevice *deviceobject;
    unsigned long ok;
} IODeviceCreate(unsigned long permissions, struct IODriver *driver, unsigned long sizeinbytes, const char *name,
    unsigned long type, unsigned long extensionsize);

void strcpy(const char *src, char *dest);
void itoa(char *str, unsigned long n);

struct IOPartitionTable;

typedef struct IOPartitionDetectFunction {
    struct IOPartitionTable *partitiontable;
    unsigned long ok;
} (*IOPartitionDetectFunction)(struct IODevice *devobject);

struct IOPartitionDetectFunction IOPartitionTableRead(struct IODevice *devobject);

struct IOPartitionSupportTable {
    const char *Name;
    IOPartitionDetectFunction Detect;
    unsigned long Reserved1;
    unsigned long Reserved2;
};

#define IOVOLUMELABELMAX 64

struct IOPartitionEntry {
    char Label[IOVOLUMELABELMAX];
    unsigned long BlockOffset;
    unsigned long SizeInBlocks;
    unsigned long ID;
    unsigned long Reserved1;
    unsigned long Reserved2;
    unsigned long Reserved3;
};

struct IOPartitionTable {
    struct IOPartitionSupportTable *Format;
    char Label[IOVOLUMELABELMAX];
    unsigned long PartitionCount;
    unsigned long Reserved1;
    unsigned long Reserved2;
    unsigned long Reserved3;
    struct IOPartitionEntry Partitions[];
};

unsigned long IODeviceSetLabel(struct IODevice *deviceobject, const char *label);

unsigned long strlen(const char *str);

struct IOPacketHeader *IOPacketFromLocation(struct IOPacketLocation *iopl);

typedef unsigned long (*IOPacketCompletionDPCRoutine)(struct IOPacketLocation *iopl);

struct IOPacketLocation {
    unsigned char FunctionCodeB;
    unsigned char StackLocationB;
    unsigned char Alignment1B;
    unsigned char Alignment2B;
    unsigned long Flags;
    unsigned long Context;
    struct IOFileControlBlock *FileControlBlock;
    IOPacketCompletionDPCRoutine CompletionRoutine;
    unsigned long Offset;
    unsigned long Length;
    unsigned long OffsetInMDL;
    struct IOPacketHeader *IOPH;
};

struct IOFileControlBlock {
    struct IOiCacheInfoBlock *CacheInfoBlock;
    struct IODispatchTable *DispatchTable;
    unsigned long SizeInBytes;
    unsigned long StackDepth;
    void *Extension;
    struct IOFileControlBlockPaged *Paged;
};

struct IOFileControlBlockPaged {
    unsigned long Flags;
    unsigned long FileType;
    struct IODevice *DeviceObject;
    void *Extension;
    struct KeTime AccessTime;
    struct KeTime ModifyTime;
    struct KeTime ChangeTime;
    struct KeTime CreationTime;
};

struct OSStatusBlock {
    unsigned long Status;
    unsigned long Length;
};

struct IOPacketHeader {
    unsigned char CurrentStackIndexB;
    unsigned char StackDepthB;
    unsigned char PriorityBoostB;
    unsigned char TypeB;
    unsigned char IOPFlagsB;
    unsigned char HeaderSizeB;
    unsigned short IOCountI;
    struct OSStatusBlock StatusBlock;
    unsigned long Timeout;
    struct MiQuotaBlock *QuotaBlock;
    struct IOPacketHeader *ParentIOP;
    struct KeEvent *Event;
    unsigned long KFlags;
    struct MmMDLHeader *MDL;
    struct IOPacketHeader *DeviceQueueNext;
    struct IOPacketHeader *DeviceQueuePrev;
};

#define IODISPATCH_READ 21
#define IODISPATCH_WRITE 22

void IOPacketCompleteLow(struct IOPacketHeader *iop, unsigned long priboost, unsigned long status);
unsigned long IOPacketLocationVirtualBuffer(struct IOPacketLocation *iopl);

unsigned long min(unsigned long n2, unsigned long n1);

unsigned long MmMDLPin(struct MmMDLHeader *mdl, unsigned long lockforwrite);

void MmMDLFlush(struct MmMDLHeader *mdl, unsigned long dma, unsigned long write, unsigned long length,
    unsigned long offset);

unsigned long KeIPLRaise(unsigned long newipl);
void KeIPLLower(unsigned long newipl);

void IOPacketWasEnqueued(struct IOPacketHeader *iop);

unsigned long IOPacketLocationPhysical(struct IOPacketLocation *iopl, unsigned long offset);
struct IOPacketLocation *IOPacketCurrentLocation(struct IOPacketHeader *iop);

#define IOBOOSTSERIAL 2
#define IOBOOSTDISK 1
#define IOBOOSTKEYBOARD 6
#define IOBOOSTMOUSE 6
#define IOBOOSTCONHOST 6
#define IOBOOSTCONSOLE IOBOOSTSERIAL
#define IOBOOSTPIPE 1

void IOPacketComplete(struct IOPacketHeader *iop, unsigned long priboost, unsigned long status);
