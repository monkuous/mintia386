.section "text", "ax", %progbits

.globl LdrI386StartSystem
.type LdrI386StartSystem, @function
LdrI386StartSystem:
    mov %esp, (SavedSP)
    mov %esp, (LdrInfoBlock + 8)
    mov (LdrInterruptStackTop), %esp

    sub $16, %esp
    movl $LdrInfoBlock, (%esp)
    calll *(LdrSystemEntryPoint)

    mov (SavedSP), %esp
    ret
.size LdrI386StartSystem, . - LdrI386StartSystem

.section "data", "aw", %progbits

.balign 4
.type SavedSP, @object
SavedSP: .long 0
.size SavedSP, . - SavedSP
