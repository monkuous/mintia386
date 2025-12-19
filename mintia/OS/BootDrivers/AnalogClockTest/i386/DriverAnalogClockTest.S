.section "text", "ax", %progbits

# 8(%esp) - dividend
# 4(%esp) - divisor
.globl signeddiv
.type signeddiv, @function
signeddiv:
    mov   8(%esp), %eax
    cltd
    idivl 4(%esp)
    ret
.size signeddiv, . - signeddiv
