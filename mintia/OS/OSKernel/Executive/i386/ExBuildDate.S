.section "PAGE$text", "ax", %progbits

.globl ExBuildDate
.type ExBuildDate, @object
ExBuildDate:
    .asciz __DATE__
.size ExBuildDate, . - ExBuildDate
