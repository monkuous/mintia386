.section "text", "ax", %progbits

# 4(%esp) - tf
.globl HALInterrupt
.type HALInterrupt, @function
HALInterrupt:
    sub $8, %esp
    mov %ebx, (%esp)
    mov %esi, 4(%esp)

    mov 12(%esp), %ecx
    mov 48(%ecx), %esi # vector
    sub $0x20, %esi

    # save old ipl
    mov (KeIPLCurrent), %ebx

    # set new ipl
    mov (HALPlatformInterruptHandlers + 4)(,%esi,8), %eax
    mov %eax, (KeIPLCurrent)

    # switch to interrupt stack
    mov %esp, %eax
    mov (HALInterruptStackTop), %esp
    sub $16, %esp
    mov %eax, 12(%esp)

    # call handler
    mov %ecx, (%esp)
    calll *HALPlatformInterruptHandlers(,%esi,8)

    # switch to old stack
    mov 12(%esp), %esp

    # restore ipl
    mov %ebx, (KeIPLCurrent)

    # perform eoi
    mov $0x20, %eax
    cmp $8, %esi
    jb 1f
    out %al, $0xa0
1:  out %al, $0x20

    # return
    mov (%esp), %ebx
    mov 4(%esp), %esi
    add $8, %esp
    ret
.size HALInterrupt, . - HALInterrupt
