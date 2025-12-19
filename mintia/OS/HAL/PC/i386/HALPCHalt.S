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
    pushl $0
    pushl $0
    lidt (%esp)
1:  int $0x80
    hlt
    jmp 1b
.size HALI386Reset, . - HALI386Reset
