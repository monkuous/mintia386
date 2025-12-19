.section "text", "ax", %progbits

.globl KeThreadContinue
KeThreadContinue:
    int3
.globl KeSafeCopyIn
KeSafeCopyIn:
    int3
.globl KeEnterUserMode
KeEnterUserMode:
    int3
.globl KeSafeStringCopyOut
KeSafeStringCopyOut:
    int3
.globl KeSafeCopyOut
KeSafeCopyOut:
    int3
.globl KeIPLCurrentGet
KeIPLCurrentGet:
    int3
.globl KeSafeProbeWrite
KeSafeProbeWrite:
    int3
.globl KeSafeGetByte
KeSafeGetByte:
    int3
.globl KeAddressSpaceSwitch
KeAddressSpaceSwitch:
    int3
.globl KeInterlockedIncrement
KeInterlockedIncrement:
    int3
.globl KeSafeStringCopyIn
KeSafeStringCopyIn:
    int3
.globl KiInterruptUsermode
KiInterruptUsermode:
    int3
.globl KiCPUInit
KiCPUInit:
    int3
.globl KeSafeProbeSystemByte
KeSafeProbeSystemByte:
    int3
.globl KeSafeMemset
KeSafeMemset:
    int3
