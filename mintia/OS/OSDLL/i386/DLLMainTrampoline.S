.section "text", "ax", %progbits

# copy arguments table from OSPEB to stack and jump to entrypoint
# does not return

.globl DLLMain
.type DLLMain, @function
DLLMain:
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

.globl DLLThreadExit
.type DLLThreadExit, @function
DLLThreadExit:
    mov %eax, (%esp)
    call OSThreadExit
    int3
.size DLLThreadExit, . - DLLThreadExit

.globl DLLSignalDispatch
.type DLLSignalDispatch, @function
DLLSignalDispatch:
    mov %esp, %ecx
    sub $16, %esp
    mov %eax, (%esp)
    mov %ecx, 4(%esp)
    call DLLSignalDispatchHL
    int3
.size DLLSignalDispatch, . - DLLSignalDispatch

.globl DLLAPCDispatch
.type DLLAPCDispatch, @function
DLLAPCDispatch:
    mov %esp, %ecx
    sub $16, %esp
    mov %eax, (%esp)
    mov %ecx, 4(%esp)
    mov %edx, 8(%esp)
    call DLLAPCDispatchHL
    int3
.size DLLAPCDispatch, . - DLLAPCDispatch

.globl DLLThreadEntry
.type DLLThreadEntry, @function
DLLThreadEntry:
    sub $20, %esp
    mov %eax, 0(%esp)
    mov %edx, 4(%esp)
    jmp *%ecx
.size DLLThreadEntry, . - DLLThreadEntry
