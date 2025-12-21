.section "text", "ax", %progbits

.globl KeInterlockedIncrement
.type KeInterlockedIncrement, @function
KeInterlockedIncrement:
    mov 4(%esp), %edx
    mov 8(%esp), %eax
    xadd %eax, (%edx)
    ret
.size KeInterlockedIncrement, . - KeInterlockedIncrement

#define KeThread_SafeAccessAbort 168
#define KeThread_SafeAccessSP 172

# 8(%esp) - src
# returns:
# 0(4(%esp)) - byte
# 4(4(%esp)) - ok
.globl KeSafeProbeSystemByte
.type KeSafeProbeSystemByte, @function
KeSafeProbeSystemByte:
    mov 8(%esp), %eax
    mov 4(%esp), %edx

    mov (KeThreadCurrent + KeThread_SafeAccessAbort), %ecx
    movl $SafeGetSystemByteFailure, (KeThreadCurrent + KeThread_SafeAccessAbort)

    movzbl (%eax), %eax

    mov %ecx, (KeThreadCurrent + KeThread_SafeAccessAbort)

    mov %eax, (%edx)
    movl $0, 4(%edx)
    ret $4
.size KeSafeProbeSystemByte, . - KeSafeProbeSystemByte

.globl SafeGetSystemByteFailure
.type SafeGetSystemByteFailure, @function
SafeGetSystemByteFailure:
    mov %ecx, (KeThreadCurrent + KeThread_SafeAccessAbort)
    mov %eax, 4(%edx)
    ret $4
.size SafeGetSystemByteFailure, . - SafeGetSystemByteFailure
