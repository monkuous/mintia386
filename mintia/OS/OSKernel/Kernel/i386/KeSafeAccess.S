.section "text", "ax", %progbits

.globl KeInterlockedIncrement
.type KeInterlockedIncrement, @function
KeInterlockedIncrement:
    mov 4(%esp), %edx
    mov 8(%esp), %eax
    lock xadd %eax, (%edx)
    ret
.size KeInterlockedIncrement, . - KeInterlockedIncrement
