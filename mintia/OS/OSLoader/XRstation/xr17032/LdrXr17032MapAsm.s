.section text

.extern FirmwareEb
.extern LdrPlatformKernelPageDirectory
.extern LdrInterruptStackTop
.extern LdrSystemEntryPoint
.extern a3xMyDevice
.extern a3xCIPtr
.extern LdrInfoBlock

LdrXr17032MapDTLBMissRoutine:
.global LdrXr17032MapDTLBMissRoutine
	mfcr zero, dtbaddr
	mov  zero, long [zero]
	mtcr dtbpte, zero
	rfe
LdrXr17032MapDTLBMissRoutineEnd:
.global LdrXr17032MapDTLBMissRoutineEnd

LdrXr17032MapITLBMissRoutine:
.global LdrXr17032MapITLBMissRoutine
	mfcr zero, itbaddr
	mov  zero, long [zero]
	mtcr itbpte, zero
	rfe
LdrXr17032MapITLBMissRoutineEnd:
.global LdrXr17032MapITLBMissRoutineEnd

LdrXr17032MapFlushTLBAll:
.global LdrXr17032MapFlushTLBAll
	li   t0, 3
	mtcr itbctrl, t0
	mtcr dtbctrl, t0

	ret

LdrXr17032MapExit:
.global LdrXr17032MapExit
	mov  t0, long [FirmwareEb]
	mtcr eb, t0
	mtcr rs, zero
	ret

;a0 - exception block virtual base
LdrXr17032MapEnablePaging:
.global LdrXr17032MapEnablePaging
	wmb

	mfcr t0, eb
	mov  long [FirmwareEb], t0, tmp=t1
	mtcr eb, a0

	; flush icache

	li   t0, 3
	mtcr icachectrl, t0

	; flush TLBs

	li   t0, 3
	mtcr itbctrl, t0
	mtcr dtbctrl, t0

	; zero out processor status

	mtcr rs, zero

	; set page table virtual base

	la   t0, 0xB0000000
	mtcr itbaddr, t0
	mtcr dtbaddr, t0

	; insert page directory and exception block into zeroth and first reserved
	; TLB entries, respectively. this will keep them permanently mapped forever.

	mtcr itbindex, zero
	mtcr dtbindex, zero

	la   t0, 0xB02C0000
	rshi t0, t0, 12
	mtcr itbtag, t0
	mtcr dtbtag, t0

	mov  t0, long [LdrPlatformKernelPageDirectory]
	rshi t0, t0, 12
	lshi t0, t0, 5
	ori  t0, t0, 0x17
	mtcr itbpte, t0
	mtcr dtbpte, t0

	mov  t0, a0
	rshi t0, t0, 12
	mtcr itbtag, t0
	mtcr dtbtag, t0

	li   t0, 0x1000
	rshi t0, t0, 12
	lshi t0, t0, 5
	ori  t0, t0, 0x17
	mtcr itbpte, t0
	mtcr dtbpte, t0

	; initialize replacement index to 4

	li   t0, 4
	mtcr itbindex, t0
	mtcr dtbindex, t0

	; set map enable bit in RS

	li   t0, 4
	mtcr rs, t0
	ret

SavedSP:
	.dl 0

LdrXr17032StartSystem:
.global LdrXr17032StartSystem
	subi sp, sp, 4
	mov  long [sp], lr

	mov  t2, sp

	mov  long [SavedSP], t2, tmp=t0

	mov  sp, long [LdrInterruptStackTop]

	subi sp, sp, 8
	mov  long [sp], 0
	mov  long [sp + 4], 0

	la   t0, LdrInterruptStackTop
	mov  t0, long [LdrSystemEntryPoint]

	mov  a1, long [a3xMyDevice]

	mov  a2, long [a3xCIPtr]

	la   a3, LdrInfoBlock
	mov  long [a3 + 8], t2

	; flush icache

	li   t1, 3
	mtcr icachectrl, t1

	jalr lr, t0, 0

	mov  sp, long [SavedSP]

	mov  lr, long [sp]
	ret
