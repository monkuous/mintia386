.section "text", "ax", %progbits

.globl HALPCIInb
.type HALPCIInb, @function
HALPCIInb:
    mov 4(%esp), %edx
    inb %dx, %al
    movzx %al, %eax
    ret
.size HALPCIInb, . - HALPCIInb

.globl HALPCIIni
.type HALPCIIni, @function
HALPCIIni:
    mov 4(%esp), %edx
    inw %dx, %ax
    movzx %ax, %eax
    ret
.size HALPCIIni, . - HALPCIIni

.globl HALPCIInl
.type HALPCIInl, @function
HALPCIInl:
    mov 4(%esp), %edx
    inl %dx, %eax
    ret
.size HALPCIInl, . - HALPCIInl

.globl HALPCIOutb
.type HALPCIOutb, @function
HALPCIOutb:
    mov 4(%esp), %edx
    mov 8(%esp), %eax
    outb %al, %dx
    ret
.size HALPCIOutb, . - HALPCIOutb

.globl HALPCIOuti
.type HALPCIOuti, @function
HALPCIOuti:
    mov 4(%esp), %edx
    mov 8(%esp), %eax
    outw %ax, %dx
    ret
.size HALPCIOuti, . - HALPCIOuti

.globl HALPCIOutl
.type HALPCIOutl, @function
HALPCIOutl:
    mov 4(%esp), %edx
    mov 8(%esp), %eax
    outl %eax, %dx
    ret
.size HALPCIOutl, . - HALPCIOutl
