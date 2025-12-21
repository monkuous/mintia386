.section "text", "ax", %progbits

# 4(%esp) - data selector
# 8(%esp) - code selector
# 12(%esp) - idtr address
# 16(%esp) - gdtr address
# 20(%esp) - tss selector
.globl KiI386Init
.type KiI386Init, @function
KiI386Init:
    # set up segmentation
    mov 16(%esp), %eax
    lgdt (%eax)

    mov 12(%esp), %eax
    lidt (%eax)

    pushl 8(%esp)
    pushl $1f
    lretl
1:  mov 4(%esp), %eax
    mov %eax, %ds
    mov %eax, %es
    mov %eax, %fs
    mov %eax, %gs
    mov %eax, %ss

    xor %eax, %eax
    lldt %ax

    mov 20(%esp), %eax
    ltr %ax

    # set up cr0
    mov $0x80050035, %eax
    mov %eax, %cr0

    ret
.size KiI386Init, . - KiI386Init

.type KiI386HandleTrap, @function
KiI386HandleTrap:
    pushl %gs
    pushl %fs
    pushl %es
    pushl %ds

    subl $32, %esp
    movl %eax, 0(%esp)
    movl %edx, 4(%esp)
    movl %ecx, 8(%esp)
    movl %esi, 12(%esp)
    movl %edi, 16(%esp)
    movl %ebx, 20(%esp)
    movl %ebp, 24(%esp)

    movl $0x10, %eax
    movl %eax, %ds
    movl %eax, %es
    movl %eax, %fs
    movl %eax, %gs

    cld
    mov %cr2, %eax
    mov %esp, %ebx
    and $~15, %esp
    sub $16, %esp
    mov %ebx, (%esp)
    mov %eax, 4(%esp)
    call KiI386Trap
    mov %ebx, %esp

.LtrapReturn:
    movl 0(%esp), %eax
    movl 4(%esp), %edx
    movl 8(%esp), %ecx
    movl 12(%esp), %esi
    movl 16(%esp), %edi
    movl 20(%esp), %ebx
    movl 24(%esp), %ebp
    addl $32, %esp

    popl %ds
    popl %es
    popl %fs
    popl %gs
    addl $8, %esp # consume vector and error code
    iret
.size KiI386HandleTrap, . - KiI386HandleTrap

.globl KiI386Syscall
.type KiI386Syscall, @function
KiI386Syscall:
    sub $12, %esp
    mov %esi, (%esp)

    mov 16(%esp), %esi # trampolines expect trapframe in esi

    mov (%esi), %eax
    test %eax, %eax
    jz .Lsysout

    cmp (OSCallCount), %eax
    ja .Lsysout

    calll *OSCallTable(,%eax,4)

.Lsysout:
    mov (%esp), %esi
    add $12, %esp
    ret
.size KiI386Syscall, . - KiI386Syscall

.globl KiThreadTrampoline
.type KiThreadTrampoline, @function
KiThreadTrampoline:
    sub $16, %esp
    sti

    movl $0, (%esp)
    call KeIPLLower

    mov %edi, (%esp)
    mov %esi, 4(%esp)
    call *%ebx
    int3
.size KiThreadTrampoline, . - KiThreadTrampoline

.globl KeIPLCurrentGet
.type KeIPLCurrentGet, @function
KeIPLCurrentGet:
    mov (KeIPLCurrent), %eax
    ret
.size KeIPLCurrentGet, . - KeIPLCurrentGet

.globl HALI386MapSwitch
.type HALI386MapSwitch, @function
HALI386MapSwitch:
    mov 4(%esp), %eax
    mov %eax, %cr3
    ret
.size HALI386MapSwitch, . - HALI386MapSwitch

# 4(%esp) - tf
.globl KiContinue
.type KiContinue, @function
KiContinue:
    mov 4(%esp), %esp
    jmp .LtrapReturn
.size KiContinue, . - KiContinue

.pushsection "INIT$text", "ax", %progbits
.balign 4
.globl KiI386IdtThunks
.type KiI386IdtThunks, @object
KiI386IdtThunks:
.popsection

.type KiI386IdtThunkCode, @function
KiI386IdtThunkCode:

.macro idt_thunk vector, errc=0
.pushsection "INIT$text", "ax", %progbits
.org \vector * 4
.long 1f
.popsection

.if \errc
1:
.else
1:  pushl $0
.endif
    pushl $\vector
    jmp KiI386HandleTrap
.endm

idt_thunk 0x00         # #DE
idt_thunk 0x01         # #DB
idt_thunk 0x02         # NMI
idt_thunk 0x03         # #BP
idt_thunk 0x04         # #OF
idt_thunk 0x05         # #BR
idt_thunk 0x06         # #UD
idt_thunk 0x07         # #NM
idt_thunk 0x08, errc=1 # #DF
idt_thunk 0x09         # #CS
idt_thunk 0x0a, errc=1 # #TS
idt_thunk 0x0b, errc=1 # #NP
idt_thunk 0x0c, errc=1 # #SS
idt_thunk 0x0d, errc=1 # #GP
idt_thunk 0x0e, errc=1 # #PF
idt_thunk 0x10         # #MF
idt_thunk 0x11         # #AC

.set .Li, 0x20
.rept 0x10
idt_thunk .Li
.set .Li, .Li + 1
.endr

idt_thunk 0x30 # syscall

.size KiI386IdtThunkCode, . - KiI386IdtThunkCode

.pushsection "INIT$text", "ax", %progbits
.org 0x31 * 4
.size KiI386IdtThunks, . - KiI386IdtThunks
.popsection
