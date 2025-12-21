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

    mov (KeThreadCurrent), %ecx
    movl $SafeGetSystemByteFailure, KeThread_SafeAccessAbort(%ecx)

    movzbl (%eax), %eax

    movl $0, KeThread_SafeAccessAbort(%ecx)

    mov %eax, (%edx)
    movl $0, 4(%edx)
    ret $4
.size KeSafeProbeSystemByte, . - KeSafeProbeSystemByte

.type SafeGetSystemByteFailure, @function
SafeGetSystemByteFailure:
    movl $0, KeThread_SafeAccessAbort(%ecx)
    mov %eax, 4(%edx)
    ret $4
.size SafeGetSystemByteFailure, . - SafeGetSystemByteFailure

#define MMHIGHESTUSERADDRESS 0x7FFEFFFF
#define STATUS_FAULT (-33)
#define STATUS_FAULT_WRITE (-100)

# 4(%esp) - sz
# 8(%esp) - src
# 12(%esp) - dest
# returns:
# %eax - 0 if success, STATUS_FAULT if fault
.globl KeSafeCopyOut
.type KeSafeCopyOut, @function
KeSafeCopyOut:
    sub $28, %esp
    mov %ebx, 12(%esp)

    mov 32(%esp), %eax
    mov 36(%esp), %edx
    mov 40(%esp), %ecx

    cmp $MMHIGHESTUSERADDRESS, %ecx
    jae 1f

    mov %eax, 0(%esp)
    mov %edx, 4(%esp)
    mov %ecx, 8(%esp)

    mov (KeThreadCurrent), %ebx
    movl $SafeAccessFailure, KeThread_SafeAccessAbort(%ebx)
    movl %esp, KeThread_SafeAccessSP(%ebx)

    call _df_memcpy

    movl $0, KeThread_SafeAccessAbort(%ebx)

    xor %eax, %eax
    mov 12(%esp), %ebx
    add $28, %esp
    ret

1:  mov $STATUS_FAULT_WRITE, %eax
    mov 12(%esp), %ebx
    add $28, %esp
    ret
.size KeSafeCopyOut, . - KeSafeCopyOut

.type SafeAccessFailure, @function
SafeAccessFailure:
    movl $0, KeThread_SafeAccessAbort(%ebx)
    movl KeThread_SafeAccessSP(%ebx), %esp

    mov 12(%esp), %ebx
    add $28, %esp
    ret
.size SafeAccessFailure, . - SafeAccessFailure

# 4(%esp) - max
# 8(%esp) - src
# 12(%esp) - dest
# returns:
# %eax - 0 if success, STATUS_FAULT if fault
.globl KeSafeStringCopyIn
.type KeSafeStringCopyIn, @function
KeSafeStringCopyIn:
    sub $28, %esp
    mov %ebx, 12(%esp)

    mov 32(%esp), %eax
    mov 36(%esp), %edx
    mov 40(%esp), %ecx

    cmp $MMHIGHESTUSERADDRESS, %edx
    jae 1f

    mov %eax, 0(%esp)
    mov %edx, 4(%esp)
    mov %ecx, 8(%esp)

    mov (KeThreadCurrent), %ebx
    movl $SafeAccessFailure, KeThread_SafeAccessAbort(%ebx)
    movl %esp, KeThread_SafeAccessSP(%ebx)

    call strncpy

    movl $0, KeThread_SafeAccessAbort(%ebx)

    xor %eax, %eax
    mov 12(%esp), %ebx
    add $28, %esp
    ret

1:  mov $STATUS_FAULT, %eax
    mov 12(%esp), %ebx
    add $28, %esp
    ret
.size KeSafeStringCopyIn, . - KeSafeStringCopyIn

# 4(%esp) - size
# 8(%esp) - src
# 12(%esp) - dest
# returns:
# %eax - 0 if success, STATUS_FAULT if fault
.globl KeSafeCopyIn
.type KeSafeCopyIn, @function
KeSafeCopyIn:
    sub $28, %esp
    mov %ebx, 12(%esp)

    mov 32(%esp), %eax
    mov 36(%esp), %edx
    mov 40(%esp), %ecx

    cmp $MMHIGHESTUSERADDRESS, %edx
    jae 1f

    mov %eax, 0(%esp)
    mov %edx, 4(%esp)
    mov %ecx, 8(%esp)

    mov (KeThreadCurrent), %ebx
    movl $SafeAccessFailure, KeThread_SafeAccessAbort(%ebx)
    movl %esp, KeThread_SafeAccessSP(%ebx)

    call _df_memcpy

    movl $0, KeThread_SafeAccessAbort(%ebx)

    xor %eax, %eax
    mov 12(%esp), %ebx
    add $28, %esp
    ret

1:  mov $STATUS_FAULT, %eax
    mov 12(%esp), %ebx
    add $28, %esp
    ret
.size KeSafeCopyIn, . - KeSafeCopyIn
