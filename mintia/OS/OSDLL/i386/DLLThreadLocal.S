#
# Implements the interlocked OSFastMutex for the xr17032 architecture, along
# with several other synchronization and thread-local features.
#

.section "text", "ax", %progbits

# fastmutex --
.globl OSFastMutexAcquire
.type OSFastMutexAcquire, @function
OSFastMutexAcquire:
    mov 4(%esp), %edx
    lock addl $1, 4(%edx)

    movl %fs:(0), %eax
    jnz .Lacquire_notowned

    mov %eax, 12(%edx)
    movl $1, 16(%edx)

    ret

.Lacquire_notowned:
    cmp %eax, 12(%edx)
    jne .Lacquire_wait

    addl $1, 16(%edx)

    ret

.Lacquire_wait:
    sub $12, %esp

    mov %edx, 0(%esp)
    call DLLFastMutexWait
    mov 0(%esp), %edx

    add $12, %esp

    mov %fs:(0), %eax
    mov %eax, 12(%edx)
    movl $1, 16(%edx)

    ret
.size OSFastMutexAcquire, . - OSFastMutexAcquire

# fastmutex --
.globl OSFastMutexRelease
.type OSFastMutexRelease, @function
OSFastMutexRelease:
    mov 4(%esp), %edx

    subl $1, 16(%edx)
    jnz .Lrelease_stillowned

    movl $0, 12(%edx)

    lock subl $1, 4(%edx)

    js .Lrelease_done

    jmp DLLFastMutexWake

.Lrelease_stillowned:

    lock subl $1, 4(%edx)

.Lrelease_done:
    ret
.size OSFastMutexRelease, . - OSFastMutexRelease

# fastmutex -- acquired
.globl OSFastMutexTryAcquire
.type OSFastMutexTryAcquire, @function
OSFastMutexTryAcquire:
    mov 4(%esp), %edx

    mov $-1, %eax
    xor %ecx, %ecx
    lock cmpxchg %ecx, 4(%edx)
    jnz .Ltryacquire_contended

    mov %fs:(0), %eax
    mov %eax, 12(%edx)
    movl $1, 16(%edx)

    mov $1, %eax
    ret

.Ltryacquire_contended:
    xor %eax, %eax
    ret
.size OSFastMutexTryAcquire, . - OSFastMutexTryAcquire

# shove this stuff in here because why not

# inc ptr -- oldcount
.globl OSInterlockedIncrement
.type OSInterlockedIncrement, @function
OSInterlockedIncrement:
    mov 4(%esp), %edx
    mov 8(%esp), %eax
    lock xadd %eax, (%edx)
    ret
.size OSInterlockedIncrement, . - OSInterlockedIncrement

# -- teb
.globl OSThreadCurrentTEB
.type OSThreadCurrentTEB, @function
OSThreadCurrentTEB:
    mov %gs:(0), %eax
    ret
.size OSThreadCurrentTEB, . - OSThreadCurrentTEB

# -- tid
.globl OSThreadCurrentTID
.type OSThreadCurrentTID, @function
OSThreadCurrentTID:
    mov %fs:(0), %eax
    ret
.size OSThreadCurrentTID, . - OSThreadCurrentTID
