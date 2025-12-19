.section "text", "ax", %progbits

.globl HALPCInb
.type HALPCInb, @function
HALPCInb:
    mov 4(%esp), %edx
    inb %dx, %al
    movzx %al, %eax
    ret
.size HALPCInb, . - HALPCInb

.globl HALPCIni
.type HALPCIni, @function
HALPCIni:
    mov 4(%esp), %edx
    inw %dx, %ax
    movzx %ax, %eax
    ret
.size HALPCIni, . - HALPCIni

.globl HALPCInl
.type HALPCInl, @function
HALPCInl:
    mov 4(%esp), %edx
    inl %dx, %eax
    ret
.size HALPCInl, . - HALPCInl

.globl HALPCOutb
.type HALPCOutb, @function
HALPCOutb:
    mov 4(%esp), %edx
    mov 8(%esp), %eax
    outb %al, %dx
    ret
.size HALPCOutb, . - HALPCOutb

.globl HALPCOuti
.type HALPCOuti, @function
HALPCOuti:
    mov 4(%esp), %edx
    mov 8(%esp), %eax
    outw %ax, %dx
    ret
.size HALPCOuti, . - HALPCOuti

.globl HALPCOutl
.type HALPCOutl, @function
HALPCOutl:
    mov 4(%esp), %edx
    mov 8(%esp), %eax
    outl %eax, %dx
    ret
.size HALPCOutl, . - HALPCOutl
