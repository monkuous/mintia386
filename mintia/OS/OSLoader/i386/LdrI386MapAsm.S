.section "text", "ax", %progbits

.globl LdrI386MapEnablePaging
.type LdrI386MapEnablePaging, @function
LdrI386MapEnablePaging:
    mov (LdrPlatformKernelPageDirectory), %eax
    mov %eax, %cr3
    mov %cr0, %eax
    or $(1 << 31), %eax
    mov %eax, %cr0
    ret
.size LdrI386MapEnablePaging, . - LdrI386MapEnablePaging
