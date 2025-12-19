#include "../bootcode/BootDefs.S"

.code16
.arch i8086

.section "header", "ax", %progbits

.type Header, @object
Header:
    .long LOAD_MAGIC
    .long _start
.size Header, . - Header

# [in] dx:ax = boot volume sector
# [in] cl = boot drive id
.globl _start
.type _start, @function
_start:
    # Ensure we're running with the right segment registers
    cli
    cld
    xor %bx, %bx
    mov %bx, %ds
    mov %bx, %es
    mov %bx, %ss
    mov $Header, %sp
    ljmp $0, $1f
1:  sti

    # Save boot args
    push %ax
    push %dx
    push %cx

    # Determine whether the processor is i386-compatible. This is done by trying to change bits 12..15 of EFLAGS,
    # and looking at what EFLAGS was actually set to. These results are architectural:
    # - i8086: Bits 12..15 are always set
    # - i286:  Bits 12..15 are always clear
    # - i386+: Bits 12..14 are read-write, and bit 15 is always clear.
    # To confirm that the processor is i386-compatible, we attempt to set bits 12..14 and clear bit 15. If these changes
    # are successful, the processor is i386-compatible. (If it were an i8086, bit 15 would be set, and if it were an
    # i286, bits 12..14 would be clear).
    pushfw
    cli
    pushfw
    pop  %ax
    or   $0x7000, %ax
    and  $0x7000, %ax
    push %ax
    popfw
    pushfw
    pop %ax
    popfw
    test $0xf000, %ax
    js .LincompatibleCpu
    jz .LincompatibleCpu

.arch i486
    # Determine whether the processor is i486-compatible. This is done by trying to change bit 18 of EFLAGS,
    # and looking at what EFLAGS was actually set to. If the change was successful, the processor is i486-compatible.
    pushfl
    pushfl
    pop %eax
    xor $(1 << 18), %eax
    push %eax
    popfl
    pushfl
    pop %edx
    popfl
    xor %edx, %eax
    test $(1 << 18), %eax
    jz .LcompatibleCpu

.arch i8086
.LincompatibleCpu:
    mov $CPUIncompatibleMessage, %si
.Lcrash:
1:  lodsb
    test %al, %al
    jz 1f
    mov $0xe, %ah
    mov $0x7, %bx
    int $0x10
    jmp 1b
1:  sti
1:  hlt
    jmp 1b

.arch default
.LcompatibleCpu:

    # Make sure we have enough memory for the loader image.
    # The bootcode does a similar check, but that one doesn't include BSS.
    mov $NoMemoryMessage, %si
    int $0x12
    movzx %ax, %eax
    shl $10, %eax
    cmp $_bss_end, %eax
    jb .Lcrash

    call EnterNativeMode
.code32
    # Restore boot args
    popl %eax
    popw %dx

    # Call main function
    xor %ebp, %ebp
    and $~15, %esp
    movzx %dl, %edx
    sub $16, %esp
    mov %edx, (%esp)
    mov %eax, 4(%esp)
    call LdrPCMain
    int3
.code16
.size _start, . - _start

.type EnterNativeMode, @function
EnterNativeMode:
    cli
    call EnableA20
    lgdt (GlobalDescriptorTable)
    mov  %cr0, %eax
    or   $1, %eax
    mov  %eax, %cr0
    ljmp $.LselCode32, $1f
.code32
1:  mov $.LselData32, %eax
    mov %eax, %ds
    mov %eax, %es
    mov %eax, %fs
    mov %eax, %gs
    mov %eax, %ss
    movzx %sp, %esp
    pushl $2
    popfl
    retw
.code16
.size EnterNativeMode, . - EnterNativeMode

.type ExitNativeMode, @function
ExitNativeMode:
.code32
    ljmp $.LselCode16, $1f
.code16
1:  mov $.LselData16, %ax
    mov %ax, %ds
    mov %ax, %es
    mov %ax, %fs
    mov %ax, %gs
    mov %ax, %ss
    mov %cr0, %eax
    and $~1, %eax
    mov %eax, %cr0
    ljmp $0, $1f
1:  xor %ax, %ax
    mov %ax, %ds
    mov %ax, %es
    mov %ax, %fs
    mov %ax, %gs
    mov %ax, %ss
    sti
    retl
.size ExitNativeMode, . - ExitNativeMode

.type EnableA20, @function
EnableA20:
    call .La20Check
    jnz .La20Done

    # Enable using BIOS
    mov $0x2401, %ax
    int $0x15
    cli

    call .La20Check
    jnz .La20Done

    # Enable using I/O port
    in $0x92, %al
    test $2, %al
    jnz .La20IoDone
    or $2, %al
    and $0xfe, %al
    out %al, $0x92

.La20IoDone:
    xor %cx, %cx
1:  call .La20Check
    loopz 1b
    jnz .La20Done

    # Enable using keyboard controller
    call .La20KbdWaitOut
    jnz .La20KbdFailed

    # Command: set output byte to next data byte
    mov $0xd1, %al
    out %al, $0x64
    call .La20KbdWaitOut
    jnz .La20KbdFailed

    # Data: new output byte with A20 enabled
    mov $0xdf, %al
    out %al, $0x60
    call .La20KbdWaitOut
    jnz .La20KbdFailed

    # Command: pulse no lines (wait for previous command to finish execution)
    mov $0xff, %al
    out %al, $0x64
    call .La20KbdWaitOut
    jnz .La20KbdFailed

    # Wait until A20 is enabled (with a timeout)
    xor %cx, %cx
1:  call .La20Check
    loopz 1b
    jnz .La20Done

.La20KbdFailed:

    mov $A20FailMessage, %si
    jmp .Lcrash

.La20Done:
    ret
.La20Check:
    push %es
    xor %ax, %ax
    not %ax
    mov %ax, %es
    mov %es:(.La20CheckWord + 16), %ax
    not %ax
    mov %ax, (.La20CheckWord)
    cmp %ax, %es:(.La20CheckWord + 16)
    pop %es
    ret
.La20CheckWord: .word 0
.La20KbdWaitOut:
    xor %cx, %cx
1:  in $0x64, %al
    test $2, %al
    loopnz 1b
    ret
.size EnableA20, . - EnableA20

.code32

.globl LdrPCHalt
.type LdrPCHalt, @function
LdrPCHalt:
    call ExitNativeMode
.code16
    sti
1:  hlt
    jmp 1b
.code32
.size LdrPCHalt, . - LdrPCHalt

.globl LdrPCCallInterrupt
.type LdrPCCallInterrupt, @function
LdrPCCallInterrupt:
    mov 4(%esp), %edx
    mov 8(%esp), %eax

    pushal

    # set interrupt vector
    mov %al, (.Lvec)
    jmp 1f
1:

    # copy input registers onto stack
    sub $44, %esp
    mov %edx, %esi
    mov %esp, %edi
    mov $11, %ecx
    rep movsl
    orl $2, 40(%esp) # set reserved-as-one bit in eflags

    call ExitNativeMode
.code16

    # set up input registers
    popal
    pop %ds
    pop %es
    pop %fs
    pop %gs
    popfl

    # call interrupt
    .byte 0xcd
.Lvec:
    .byte 0x00

    # save output registers
    pushfl
    push %gs
    push %fs
    push %es
    push %ds
    pushal

    call EnterNativeMode
.code32

    # copy output registers off of stack
    mov %esp, %esi
    mov 64(%esp), %edi
    mov $11, %ecx
    rep movsl
    add $44, %esp

    # return
    popal
    ret
.size LdrPCCallInterrupt, . - LdrPCCallInterrupt

.type GlobalDescriptorTable, @object
GlobalDescriptorTable:
    .word .LgdtEnd - GlobalDescriptorTable - 1
    .long GlobalDescriptorTable
    .word 0
.set .LselCode16, . - GlobalDescriptorTable
    .quad 0x009b000000ffff
.set .LselData16, . - GlobalDescriptorTable
    .quad 0x0093000000ffff
.set .LselCode32, . - GlobalDescriptorTable
    .quad 0xcf9b000000ffff
.set .LselData32, . - GlobalDescriptorTable
    .quad 0xcf93000000ffff
.LgdtEnd:
.size GlobalDescriptorTable, . - GlobalDescriptorTable

.type CPUIncompatibleMessage, @object
CPUIncompatibleMessage: .asciz "\r\nMINTIA requires an i486-compatible processor.\r\nPress Ctrl+Alt+Del to restart.\r\n"
.size CPUIncompatibleMessage, . - CPUIncompatibleMessage

.type A20FailMessage, @object
A20FailMessage: .asciz "\r\nFailed to enable A20 line.\r\nPress Ctrl+Alt+Del to restart.\r\n"
.size A20FailMessage, . - A20FailMessage

.type NoMemoryMessage, @object
NoMemoryMessage: .asciz "\r\nNot enough memory.\r\nPress Ctrl+Alt+Del to restart.\r\n"
.size NoMemoryMessage, . - NoMemoryMessage
