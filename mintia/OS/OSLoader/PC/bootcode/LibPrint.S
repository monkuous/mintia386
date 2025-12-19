.type Error, @function
Error:
    call Message
    mov $ErrorTail, %si
    call Message
    sti
1:  hlt
    jmp 1b
.size Error, . - Error

.type Message, @function
Message:
1:  lodsb
    test %al, %al
    jz 1f
    mov $0xe, %ah
    mov $0x7, %bx
    int $0x10
    jmp 1b
1:  ret
.size Message, . - Message

.type ErrorTail, @object
ErrorTail: .asciz "\r\nPress Ctrl+Alt+Del to restart.\r\n"
.size ErrorTail, . - ErrorTail
