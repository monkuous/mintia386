.section "text", "ax", %progbits

# copy arguments table from OSPEB to stack and jump to entrypoint
# does not return

.globl DLLMain
.type DLLMain, @function
DLLMain:
    pushl $0
    sub  $12, %esp
    call DLLMainHL
    nop
.size DLLMain, . - DLLMain

# 12(%esp) - program entry
# 8(%esp) - argv
# 4(%esp) - argc
.globl DLLMainTrampoline
.type DLLMainTrampoline, @function
DLLMainTrampoline:
    sub $12, %esp

    mov 16(%esp), %eax
    mov 20(%esp), %edx

    mov %eax, 0(%esp)
    mov %edx, 4(%esp)

    call *24(%esp)

    mov %eax, 0(%esp)
    call OSExit
    nop
.size DLLMainTrampoline, . - DLLMainTrampoline
