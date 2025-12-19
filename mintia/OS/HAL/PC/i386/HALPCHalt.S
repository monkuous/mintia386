.section "text", "ax", %progbits

.globl HALCPUHalt
.type HALCPUHalt, @function
HALCPUHalt:
    hlt
    ret
.size HALCPUHalt, . - HALCPUHalt
