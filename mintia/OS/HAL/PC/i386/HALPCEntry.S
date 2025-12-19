.section "text", "ax", %progbits

.globl _start
.type _start, @function
_start:
    jmp HALMain
.size _start, . - _start
