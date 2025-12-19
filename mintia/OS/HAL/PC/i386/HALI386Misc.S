.section "text", "ax", %progbits

# -- rs
.globl HALCPUInterruptDisable
.type HALCPUInterruptDisable, @function
HALCPUInterruptDisable:
    pushfl
    pop %eax
    cli
    ret
.size HALCPUInterruptDisable, . - HALCPUInterruptDisable

# rs --
.globl HALCPUInterruptRestore
.type HALCPUInterruptRestore, @function
HALCPUInterruptRestore:
    test $0x200, 4(%esp)
    jz 1f
    sti
1:  ret
.size HALCPUInterruptRestore, . - HALCPUInterruptRestore
