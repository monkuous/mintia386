# [in] cx:ax = base sector
# [in] dl = boot drive
.type IOInit, @function
IOInit:
    mov %ax, (IOBase)
    mov %cx, (IOBase + 2)
    mov %dl, (IODrive)

    mov $0x41, %ah
    mov $0x55aa, %bx
    int $0x13
    jc .LnoInt13Ext
    cmp $0xaa55, %bx
    jne .LnoInt13Ext
    test $1, %cl
    jz .LnoInt13Ext

    sub $0x1a, %sp
    mov $0x48, %ah
    mov (IODrive), %dl
    mov %sp, %si
    movw $0x1a, (%si)
    movw $0, 2(%si)
    int $0x13
    jc .LinitFailed

    mov 0x18(%si), %ax
    mov %ax, (IOBlockSize)

    movw $IOReadLBA, (IORead)

    add $0x1a, %sp
    ret

.LnoInt13Ext:
    mov $0x08, %ah
    mov (IODrive), %dl
    xor %di, %di
    push %es
    int $0x13
    pop %es
    jc .LinitFailed

    and $0x3f, %cx
    mov %cx, (.LtrackSize)

    mov %dh, %dl
    xor %dh, %dh
    inc %dx
    mov %dx, (.LnumHeads)

    movw $IOReadCHS, (IORead)
    movw $512, (IOBlockSize)

    mov $1024, %ax
    mulw (.LtrackSize) # the first mul _must_ be track size so that the highest possible result fits in 16 bits
    mulw (.LnumHeads)
    dec %ax
    sbb $0, %dx
    mov %ax, (.LaddressableLimit)
    mov %dx, (.LaddressableLimit + 2)

    ret
.LinitFailed:
    mov $IOInitFailMessage, %si
    jmp Error
.size IOInit, . - IOInit

.type IOReadLBA, @function
IOReadLBA:
    # Create disk address packet on stack
    xor %si, %si
    push %si
    push %si
    push %dx
    push %ax
    push %es
    push %bx
    push %cx
    mov $0x10, %ax
    push %ax
    mov %sp, %si
    # Apply sector offset
    mov (IOBase), %ax
    mov (IOBase + 2), %dx
    add %ax, 8(%si)
    adc %dx, 10(%si)
    adcw $0, 12(%si)
    adcw $0, 14(%si)
.LlbaReadIteration:
    # Limit the sector count to 127
    mov %cx, 2(%si)
    cmp $0x7f, %cx
    jbe .LdoLbaRead
    movw $0x7f, 2(%si)
.LdoLbaRead:
    # Perform the read
    mov $0x42, %ah
    mov (IODrive), %dl
    int $0x13
    jc .LioReadFailed
    # Advance sector number
    mov 2(%si), %ax
    add %ax, 8(%si)
    adcw $0, 10(%si)
    adcw $0, 12(%si)
    adcw $0, 14(%si)
    # Advance buffer
    mulw (IOBlockSize)
    divw (%si)
    add %dx, 4(%si)
    add %ax, 6(%si)
    # Advance count
    sub 2(%si), %cx
    ja .LlbaReadIteration
    # Return
    pop %bx
    pop %bx
    pop %bx
    pop %es
    add $8, %sp
    ret
.size IOReadLBA, . - IOReadLBA

.type IOReadCHS, @function
IOReadCHS:
    mov %cx, %si
    # Apply sector offset
    add (IOBase), %ax
    adc (IOBase + 2), %dx
    jc .LioReadFailed
    # Check bounds
    cmp %ax, (.LaddressableLimit)
    mov (.LaddressableLimit + 2), %cx
    sbb %dx, %cx
    jc .LioReadFailed
    # Get sector number and track ID
    mov %ax, %cx
    mov %dx, %ax
    xor %dx, %dx
    divw (.LtrackSize)
    xchg %ax, %cx
    divw (.LtrackSize)
    xchg %dx, %cx
    # Track ID in dx:ax, 0-based sector number in cx
    # Now separate track ID into cylinder and head
    divw (.LnumHeads)
    # Cylinder number in ax, head number in dx, 0-based sector number in cx
.LchsReadIteration:
    push %ax
    push %dx
    push %cx
    # Determine number of sectors until 64K boundary
    mov %es, %ax
    mov $4, %cl
    shl %cl, %ax
    add %bx, %ax
    neg %ax
    cmc
    sbb $0, %ax
    xor %dx, %dx
    divw (IOBlockSize)
    # Determine number of sectors until track boundary
    mov %cx, %di
    neg %di
    add (.LtrackSize), %di
    # Determine number of sectors to read: min(sectorsUntil64KBoundary, sectorsUntilTrackBoundary, remainingSectors)
    # Note that the sectors-until-track-boundary limit also limits the result to 63 sectors, so we don't need to
    # do the 127 limit ourselves.
    cmp %ax, %di
    jbe 1f
    mov %ax, %di
1:  cmp %si, %di
    jbe 1f
    mov %si, %di
1:  pop %cx
    pop %dx
    pop %ax
    push %ax
    push %dx
    push %cx
    push %di
    # ax = cylinder, dx = head, cx = 0-based sector number, si = remaining sectors, di = sectors for current iteration
    inc %cx
    ror %ah
    ror %ah
    or %ah, %cl
    mov %al, %ch
    mov %dl, %dh
    mov (IODrive), %dl
    mov %di, %ax
    mov $2, %ah
    # Registers prepared for INT 13 call
    mov $5, %di
.LdoChsRead:
    push %dx
    stc
    int $0x13
    sti
    pop %dx
    jnc .LchsReadOk
    dec %di
    jz .LioReadFailed
    push %ax
    xor %ax, %ax
    int $0x13
    pop %ax
    jmp .LdoChsRead
.LchsReadOk:
    pop %di
    pop %cx
    pop %dx
    pop %ax
    # Advance sector number
    add %di, %cx
    cmp (.LtrackSize), %cx
    jb .LchsAdvanceBuffer
    xor %cx, %cx
    inc %dx
    cmp (.LnumHeads), %dx
    jb .LchsAdvanceBuffer
    xor %dx, %dx
    inc %ax
.LchsAdvanceBuffer:
    # Advance buffer
    push %ax
    push %dx
    push %cx
    mov $16, %cx
    mov %di, %ax
    mulw (IOBlockSize)
    div %cx
    add %dx, %bx
    mov %es, %dx
    add %ax, %dx
    mov %dx, %es
    pop %cx
    pop %dx
    pop %ax
    # Advance count
    sub %di, %si
    ja .LchsReadIteration
    # Return
    ret
.size IOReadCHS, . - IOReadCHS

# [inout] es:bx = destination
# [in] dx:ax = sector number
# [in] cx = number of sectors
# clobbers: ax, bx, cx, dx, si, di
.type IORead, @object
IORead: .word 0
.size IORead, . - IORead

.type IOBlockSize, @object
IOBlockSize: .word 0
.size IOBlockSize, . - IOBlockSize

.type IOBase, @object
IOBase: .long 0
.size IOBase, . - IOBase

.type IODrive, @object
IODrive: .byte 0
.size IODrive, . - IODrive

.type IOGeometry, @object
IOGeometry:
.LtrackSize: .word 0
.LnumHeads: .word 0
.LaddressableLimit: .long 0
.size IOGeometry, . - IOGeometry

.type IOInitFailMessage, @object
IOInitFailMessage: .asciz "\r\nFailed to initialize I/O."
.size IOInitFailMessage, . - IOInitFailMessage
