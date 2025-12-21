.section "text", "ax", %progbits

.globl HALCPUHalt
.type HALCPUHalt, @function
HALCPUHalt:
    hlt
    ret
.size HALCPUHalt, . - HALCPUHalt

.globl HALI386Reset
.type HALI386Reset, @function
HALI386Reset:
    cli
1:  in $0x64, %al
    test $2, %al
    jnz 1b
    mov $0xfe, %al
    out %al, $0x64
1:  hlt
    jmp 1b
.size HALI386Reset, . - HALI386Reset
