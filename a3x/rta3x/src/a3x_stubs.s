.section text

.extern a3xFwctx
.extern a3xCIPtr

subi sp, sp, 0
a3xReturn:
.global a3xReturn
	la   t0, a3xFwctx
	mov  sp, long [t0]

	mov  lr, long [sp]
	addi sp, sp, 4
	ret

.define _a3xCIC_Putc 0
.define _a3xCIC_Getc 4
.define _a3xCIC_Gets 8
.define _a3xCIC_Puts 12
.define _a3xCIC_DevTree 16
.define _a3xCIC_Malloc 20
.define _a3xCIC_Calloc 24
.define _a3xCIC_Free 28
.define _a3xCIC_DevTreeWalk 32
.define _a3xCIC_DeviceParent 36
.define _a3xCIC_DeviceSelectNode 40
.define _a3xCIC_DeviceSelect 44
.define _a3xCIC_DeviceDGetProperty 48
.define _a3xCIC_DeviceDGetMethod 52
.define _a3xCIC_DeviceDCallMethod 56
.define _a3xCIC_DeviceExit 60
.define _a3xCIC_DeviceDSetProperty 64
.define _a3xCIC_DeviceDCallMethodPtr 68
.define _a3xCIC_DevIteratorInit 72
.define _a3xCIC_DevIterate 76
.define _a3xCIC_DeviceDGetName 80
.define _a3xCIC_ConsoleUserOut 84
.define _a3xCIC_DGetCurrent 88

SavedS0:
	.dl 0

SavedLR:
	.dl 0

; buffer maxchars --
a3xGets:
.global a3xGets
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_Gets]
	jalr lr, t0, 0

	mtcr rs, s0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; char --
a3xPutc:
.global a3xPutc
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_Putc]
	jalr lr, t0, 0

	mtcr rs, s0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; -- char
a3xGetc:
.global a3xGetc
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_Getc]
	jalr lr, t0, 0

	mtcr rs, s0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; str --
a3xPuts:
.global a3xPuts
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_Puts]
	jalr lr, t0, 0

	mtcr rs, s0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; -- root dcp
a3xAPIDevTree:
.global a3xAPIDevTree
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_DevTree]
	jalr lr, t0, 0

	mtcr rs, s0

    mov  a3, a0
    mov  a2, a1

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; sz -- ptr
a3xMalloc:
.global a3xMalloc
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_Malloc]
	jalr lr, t0, 0

	mtcr rs, s0

    mov  a3, a0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; sz -- ptr
a3xCalloc:
.global a3xCalloc
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_Calloc]
	jalr lr, t0, 0

	mtcr rs, s0

    mov  a3, a0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; ptr --
a3xFree:
.global a3xFree
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_Free]
	jalr lr, t0, 0

	mtcr rs, s0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; path -- node
a3xDevTreeWalk:
.global a3xDevTreeWalk
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_DevTreeWalk]
	jalr lr, t0, 0

	mtcr rs, s0

    mov  a3, a0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; --
a3xDeviceParent:
.global a3xDeviceParent
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_DeviceParent]
	jalr lr, t0, 0

	mtcr rs, s0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; node --
a3xDeviceSelectNode:
.global a3xDeviceSelectNode
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_DeviceSelectNode]
	jalr lr, t0, 0

	mtcr rs, s0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; path --
a3xDeviceSelect:
.global a3xDeviceSelect
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_DeviceSelect]
	jalr lr, t0, 0

	mtcr rs, s0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; name -- value
a3xDGetProperty:
.global a3xDGetProperty
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_DeviceDGetProperty]
	jalr lr, t0, 0

	mtcr rs, s0

    mov  a3, a0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; name -- ptr
a3xDGetMethod:
.global a3xDGetMethod
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_DeviceDGetMethod]
	jalr lr, t0, 0

	mtcr rs, s0

    mov  a3, a0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; name -- success
a3xDCallMethod:
.global a3xDCallMethod
    subi sp, sp, 4
    mov  long [sp], s0
    mov  s0, sp

	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

    mov  t0, a1
    mov  a1, a0
    mov  a0, t0

    sub  t1, sp, t0 LSH 2
    subi sp, t1, 4
    beq  t0, .copydone
.copyone:
    subi t0, t0, 1
    mov  t2, long [a2 + t0 LSH 2]
    mov  long [t1 + t0 LSH 2], t2
    bne  t0, .copyone
.copydone:

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_DeviceDCallMethod]
	jalr lr, t0, 0

	mtcr rs, s0

    mov  t0, a2
    mov  t1, a3
    mov  a3, a0
    mov  a2, a1
    mov  a1, t0
    mov  a0, t1

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]

    mov  sp, s0
    mov  s0, long [sp]
    addi sp, sp, 4
	ret

; --
a3xDeviceExit:
.global a3xDeviceExit
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_DeviceExit]
	jalr lr, t0, 0

	mtcr rs, s0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; prop name --
a3xDSetProperty:
.global a3xDSetProperty
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_DeviceDSetProperty]
	jalr lr, t0, 0

	mtcr rs, s0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; ptr --
a3xDCallMethodPtr:
.global a3xDCallMethodPtr
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_DeviceDCallMethodPtr]
	jalr lr, t0, 0

	mtcr rs, s0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; -- iter
a3xDevIteratorInit:
.global a3xDevIteratorInit
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_DevIteratorInit]
	jalr lr, t0, 0

	mtcr rs, s0

    mov  a3, a0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; iter -- iter
a3xDevIterate:
.global a3xDevIterate
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_DevIterate]
	jalr lr, t0, 0

	mtcr rs, s0

    mov  a3, a0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; -- name
a3xDGetName:
.global a3xDGetName
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_DeviceDGetName]
	jalr lr, t0, 0

	mtcr rs, s0

    mov  a3, a0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; --
a3xConsoleUserOut:
.global a3xConsoleUserOut
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_ConsoleUserOut]
	jalr lr, t0, 0

	mtcr rs, s0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret

; -- current
a3xDGetCurrent:
.global a3xDGetCurrent
	mov  long [SavedS0], s0, tmp=t0
	mov  long [SavedLR], lr, tmp=t0

	mfcr s0, rs
	andi t0, s0, 0xFFF8 ;disable paging and interrupts
	mtcr rs, t0

	mov  t0, long [a3xCIPtr]
	mov  t0, long [t0 + _a3xCIC_DGetCurrent]
	jalr lr, t0, 0

	mtcr rs, s0

    mov  a3, a0

	mov  lr, long [SavedLR]
	mov  s0, long [SavedS0]
	ret
