.section "text", "ax", %progbits

.globl bitget
.type bitget, @function
bitget:
    mov 4(%esp), %cl
    mov 8(%esp), %eax
    shr %cl, %eax
    and $1, %eax
    ret
.size bitget, . - bitget

.globl bitset
.type bitset, @function
bitset:
    mov 4(%esp), %cl
    mov $1, %eax
    shl %cl, %eax
    or  8(%esp), %eax
    ret
.size bitset, . - bitset

.globl bitclear
.type bitclear, @function
bitclear:
    mov 4(%esp), %cl
    mov $0xfffffffe, %eax
    rol %cl, %eax
    and 8(%esp), %eax
    ret
.size bitclear, . - bitclear
