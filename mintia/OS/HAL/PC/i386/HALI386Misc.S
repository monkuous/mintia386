.section "text", "ax", %progbits

# -- rs
.globl HALCPUInterruptDisable
.type HALCPUInterruptDisable, @function
HALCPUInterruptDisable:
    pushfl
    pop %eax
    cli
    ret
.size HALCPUInterruptDisable, . - HALCPUInterruptDisable

# rs --
.globl HALCPUInterruptRestore
.type HALCPUInterruptRestore, @function
HALCPUInterruptRestore:
    testl $0x200, 4(%esp)
    jz 1f
    sti
1:  ret
.size HALCPUInterruptRestore, . - HALCPUInterruptRestore

# -- modeldata
.globl HALPCGetCPUModel
.type HALPCGetCPUModel, @function
HALPCGetCPUModel:
    push %ebx

    # Check if we have CPUID
    pushfl
    pushfl
    pop %eax
    xor $(1 << 21), %eax
    push %eax
    popfl
    pushfl
    pop %edx
    popfl
    xor %edx, %eax
    test $(1 << 21), %eax
    jnz .Lnocpuid

    # Get brand string
    mov $0x80000000, %eax
    cpuid
    cmp $0x80000004, %eax
    jb .LbasicModel

    mov $0x80000002, %eax
    cpuid
    mov %eax, (HALCPUModel)
    mov %ebx, (HALCPUModel + 4)
    mov %ecx, (HALCPUModel + 8)
    mov %edx, (HALCPUModel + 12)

    mov $0x80000003, %eax
    cpuid
    mov %eax, (HALCPUModel + 16)
    mov %ebx, (HALCPUModel + 20)
    mov %ecx, (HALCPUModel + 24)
    mov %edx, (HALCPUModel + 28)

    mov $0x80000004, %eax
    cpuid
    mov %eax, (HALCPUModel + 32)
    mov %ebx, (HALCPUModel + 36)
    mov %ecx, (HALCPUModel + 40)
    mov %edx, (HALCPUModel + 44)

.Lnoextra:
    xor %eax, %eax
    pop %ebx
    ret

.LbasicModel:
    # Get brand name
    xor %eax, %eax
    cpuid
    mov %ebx, (HALCPUModel)
    mov %edx, (HALCPUModel + 4)
    mov %ecx, (HALCPUModel + 8)

    # Get model data
    cmp $1, %eax
    jb .Lnoextra
    mov $1, %eax
    cpuid
    or $(1 << 31), %eax # ensure the result is non-zero even if the fields are all zero
    pop %ebx
    ret

.Lnocpuid:
    mov $-1, %eax
    pop %ebx
    ret
.size HALPCGetCPUModel, . - HALPCGetCPUModel

.globl HALIcacheSynchronize
.type HALIcacheSynchronize, @function
HALIcacheSynchronize:
    ret
.size HALIcacheSynchronize, . - HALIcacheSynchronize

.globl HALCPUContextSwitch
.type HALCPUContextSwitch, @function
HALCPUContextSwitch:
    sub $84, %esp

    mov %esi, 12(%esp)
    mov %edi, 16(%esp)
    mov %ebx, 20(%esp)
    mov %ebp, 24(%esp)

    mov (KiI386Gdt + 0x28), %eax
    mov (KiI386Gdt + 0x2c), %edx

    mov %eax, 76(%esp)
    mov %edx, 80(%esp)

    mov 92(%esp), %edi
    mov %esp, (%edi)
    mov 88(%esp), %esp

    mov 12(%esp), %esi
    mov 16(%esp), %edi
    mov 20(%esp), %ebx
    mov 24(%esp), %ebp

    mov 76(%esp), %eax
    mov 80(%esp), %edx

    mov %eax, (KiI386Gdt + 0x28)
    mov %edx, (KiI386Gdt + 0x2c)

    add $84, %esp
    ret
.size HALCPUContextSwitch, . - HALCPUContextSwitch

.globl HALI386TLBFlush
.type HALI386TLBFlush, @function
HALI386TLBFlush:
    mov 4(%esp), %eax
    invlpg (%eax)
    ret
.size HALI386TLBFlush, . - HALI386TLBFlush

.globl HALI386TLBFlushAll
.type HALI386TLBFlushAll, @function
HALI386TLBFlushAll:
    mov %cr3, %eax
    mov %eax, %cr3
    ret
.size HALI386TLBFlushAll, . - HALI386TLBFlushAll

.globl HALCPUInterruptEnable
.type HALCPUInterruptEnable, @function
HALCPUInterruptEnable:
    sti
    ret
.size HALCPUInterruptEnable, . - HALCPUInterruptEnable
