.section "text", "ax", %progbits

.globl HALPlatformConsoleGetc
HALPlatformConsoleGetc:
    int3
.globl HALPlatformIsComputerOnFire
HALPlatformIsComputerOnFire:
    int3
.globl HALPlatformConsolePutc
HALPlatformConsolePutc:
    int3
.globl KVFontQuery
KVFontQuery:
    int3
.globl KVDrawEmptyRectangle
KVDrawEmptyRectangle:
    int3
.globl KVI8ToNative
KVI8ToNative:
    int3
.globl KVDrawFilledRectangle
KVDrawFilledRectangle:
    int3
.globl KVDrawCharacter
KVDrawCharacter:
    int3
.globl HALIcacheSynchronize
HALIcacheSynchronize:
    int3
.globl KVFontGet
KVFontGet:
    int3
.globl KVClearScreen
KVClearScreen:
    int3
.globl KVQuery
KVQuery:
    int3
.globl HALNvramQuery
HALNvramQuery:
    int3
.globl HALNvramSet
HALNvramSet:
    int3
.globl HALCPUContextSwitch
HALCPUContextSwitch:
    int3
.globl KVInit
KVInit:
    int3
.globl HALCPUTrapFrameAbort
HALCPUTrapFrameAbort:
    int3
.globl HALCPUContextInit
HALCPUContextInit:
    int3
.globl HALNvramRead
HALNvramRead:
    int3
.globl HALCPUInterruptEnable
HALCPUInterruptEnable:
    int3
.globl HALCPUIsUserTrapFrame
HALCPUIsUserTrapFrame:
    int3
