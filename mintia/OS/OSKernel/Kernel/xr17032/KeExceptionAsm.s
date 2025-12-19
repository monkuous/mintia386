.section text

.define OSContext_SIZEOF 136
.define OSContext_sp 116
.define OSContext_ers 120
.define OSContext_epc 124
.define OSContext_t0 0
.define OSContext_t1 4
.define OSContext_t2 8
.define OSContext_t3 12
.define OSContext_t4 16
.define OSContext_t5 20
.define OSContext_a0 24
.define OSContext_a1 28
.define OSContext_a2 32
.define OSContext_a3 36
.define OSContext_s0 40
.define OSContext_s1 44
.define OSContext_s2 48
.define OSContext_s3 52
.define OSContext_s4 56
.define OSContext_s5 60
.define OSContext_s6 64
.define OSContext_s7 68
.define OSContext_s8 72
.define OSContext_s9 76
.define OSContext_s10 80
.define OSContext_s11 84
.define OSContext_s12 88
.define OSContext_s13 92
.define OSContext_s14 96
.define OSContext_s15 100
.define OSContext_s16 104
.define OSContext_s17 108
.define OSContext_s18 112
.define OSContext_lr 128
.define IPLLOW 0
.define PAGEDIRECTORY 0xB02C0000

.extern KeThreadCurrentStackTop
.extern HALInterruptNested
.extern KeThreadCurrentStackBottom
.extern KiXr17032Exception
.extern KiXr17032Exception
.extern KiStackOverflow
.extern KeIPLLower
.extern OSCallCount
.extern OSCallTable
.extern HALXr17032SavedEV
.extern HALXr17032TLBFlushAll
.extern KeIPLCurrent

KiXr17032ExceptionVector:
.global KiXr17032ExceptionVector
	mtcr scratch0, t0 ; save t0 to free it as scratch
	mtcr scratch1, t1 ; ditto with t1
	mtcr scratch2, sp ; save stack pointer
	mtcr scratch3, sp ; save trace link

	mfcr t0, rs

	andi t1, t0, 256
	beq  t1, .waskernel

	mov  sp, long [KeThreadCurrentStackTop] ; load new sp for current thread

	mtcr scratch3, zero ; this was a usermode sp, zero out the trace link

.waskernel:
	subi sp, sp, OSContext_SIZEOF

	mov  t1, long [HALInterruptNested]
	bne  t1, .skipoverflowcheck

	mov  t1, long [KeThreadCurrentStackBottom]
	sub  t1, sp, t1
	blt  t1, .overflow

.skipoverflowcheck:
	mfcr t1, scratch2
	mov  long [sp + OSContext_sp],  t1
	mov  long [sp + OSContext_ers], t0 ; ers was still in t0

	mfcr t1, epc
	mov  long [sp + OSContext_epc], t1

	mfcr t1, scratch0
	mov  long [sp + OSContext_t0],  t1

	mfcr t1, scratch1
	mov  long [sp + OSContext_t1],  t1

	mov  long [sp + OSContext_t2],  t2
	mov  long [sp + OSContext_t3],  t3
	mov  long [sp + OSContext_t4],  t4
	mov  long [sp + OSContext_t5],  t5
	mov  long [sp + OSContext_a0],  a0
	mov  long [sp + OSContext_a1],  a1
	mov  long [sp + OSContext_a2],  a2
	mov  long [sp + OSContext_a3],  a3
	mov  long [sp + OSContext_s0],  s0
	mov  long [sp + OSContext_s1],  s1
	mov  long [sp + OSContext_s2],  s2
	mov  long [sp + OSContext_s3],  s3
	mov  long [sp + OSContext_s4],  s4
	mov  long [sp + OSContext_s5],  s5
	mov  long [sp + OSContext_s6],  s6
	mov  long [sp + OSContext_s7],  s7
	mov  long [sp + OSContext_s8],  s8
	mov  long [sp + OSContext_s9],  s9
	mov  long [sp + OSContext_s10], s10
	mov  long [sp + OSContext_s11], s11
	mov  long [sp + OSContext_s12], s12
	mov  long [sp + OSContext_s13], s13
	mov  long [sp + OSContext_s14], s14
	mov  long [sp + OSContext_s15], s15
	mov  long [sp + OSContext_s16], s16
	mov  long [sp + OSContext_s17], s17
	mov  long [sp + OSContext_s18], tp
	mov  long [sp + OSContext_lr],  lr

	rshi a1, t0, 28
	andi a1, a1, 15
	mfcr a2, ebadaddr
	mov  a0, sp ; give KiXr17032Exception our context

	subi sp, sp, 12
	mov  long [sp + 8], lr
	mfcr t0, epc
	mov  long [sp + 4], t0
	mfcr t0, scratch3
	mov  long [sp], t0

	jal  KiXr17032Exception ; call KiXr17032Exception, to handle the exception

	addi sp, sp, 12

	mov  t0, long [sp + OSContext_ers]
	mtcr rs, t0

	mov  t0, long [sp + OSContext_epc]
	mtcr epc, t0

	mov  t0,  long [sp + OSContext_t0]
	mov  t1,  long [sp + OSContext_t1]
	mov  t2,  long [sp + OSContext_t2]
	mov  t3,  long [sp + OSContext_t3]
	mov  t4,  long [sp + OSContext_t4]
	mov  t5,  long [sp + OSContext_t5]
	mov  a0,  long [sp + OSContext_a0]
	mov  a1,  long [sp + OSContext_a1]
	mov  a2,  long [sp + OSContext_a2]
	mov  a3,  long [sp + OSContext_a3]
	mov  s0,  long [sp + OSContext_s0]
	mov  s1,  long [sp + OSContext_s1]
	mov  s2,  long [sp + OSContext_s2]
	mov  s3,  long [sp + OSContext_s3]
	mov  s4,  long [sp + OSContext_s4]
	mov  s5,  long [sp + OSContext_s5]
	mov  s6,  long [sp + OSContext_s6]
	mov  s7,  long [sp + OSContext_s7]
	mov  s8,  long [sp + OSContext_s8]
	mov  s9,  long [sp + OSContext_s9]
	mov  s10, long [sp + OSContext_s10]
	mov  s11, long [sp + OSContext_s11]
	mov  s12, long [sp + OSContext_s12]
	mov  s13, long [sp + OSContext_s13]
	mov  s14, long [sp + OSContext_s14]
	mov  s15, long [sp + OSContext_s15]
	mov  s16, long [sp + OSContext_s16]
	mov  s17, long [sp + OSContext_s17]
	mov  tp,  long [sp + OSContext_s18]

	mov  lr, long [sp + OSContext_lr]
	mov  sp, long [sp + OSContext_sp]

	rfe

.overflow:
	mov  a1, sp
	mov  sp, long [KiXr17032Exception]

	subi sp, sp, 8
	mfcr t0, epc
	mov  long [sp + 4], t0
	mfcr t0, scratch3
	mov  long [sp], t0

	mfcr a0, rs
	jal  KiStackOverflow

.hang:
	b    .hang

KiLoadInitialContext:
.global KiLoadInitialContext
	mov  t0, long [sp + OSContext_ers]
	mtcr rs, t0

	mov  t0, long [sp + OSContext_epc]
	mtcr epc, t0

	mov  t0,  long [sp + OSContext_t0]
	mov  t1,  long [sp + OSContext_t1]
	mov  t2,  long [sp + OSContext_t2]
	mov  t3,  long [sp + OSContext_t3]
	mov  t4,  long [sp + OSContext_t4]
	mov  t5,  long [sp + OSContext_t5]
	mov  a0,  long [sp + OSContext_a0]
	mov  a1,  long [sp + OSContext_a1]
	mov  a2,  long [sp + OSContext_a2]
	mov  a3,  long [sp + OSContext_a3]
	mov  s0,  long [sp + OSContext_s0]
	mov  s1,  long [sp + OSContext_s1]
	mov  s2,  long [sp + OSContext_s2]
	mov  s3,  long [sp + OSContext_s3]
	mov  s4,  long [sp + OSContext_s4]
	mov  s5,  long [sp + OSContext_s5]
	mov  s6,  long [sp + OSContext_s6]
	mov  s7,  long [sp + OSContext_s7]
	mov  s8,  long [sp + OSContext_s8]
	mov  s9,  long [sp + OSContext_s9]
	mov  s10, long [sp + OSContext_s10]
	mov  s11, long [sp + OSContext_s11]
	mov  s12, long [sp + OSContext_s12]
	mov  s13, long [sp + OSContext_s13]
	mov  s14, long [sp + OSContext_s14]
	mov  s15, long [sp + OSContext_s15]
	mov  s16, long [sp + OSContext_s16]
	mov  s17, long [sp + OSContext_s17]
	mov  tp,  long [sp + OSContext_s18]

	mov  lr, long [sp + OSContext_lr]
	mov  sp, long [sp + OSContext_sp]

	rfe

KiThreadTrampoline:
.global KiThreadTrampoline
	mov  s0, a0
	mov  s1, a1
	mov  s2, a2

	li   a0, IPLLOW
	jal  KeIPLLower

	mov  a0, s0
	mov  a1, s1

	jr   s2

; a0 - tf
KiContinue:
.global KiContinue
	mov  sp, a0
	j    KiLoadInitialContext

; a0 - tf
KiXr17032Syscall:
.global KiXr17032Syscall
	subi sp, sp, 20
	mov  long [sp], zero
	mov  long [sp + 4], s0
	mov  long [sp + 8], s1
	mov  long [sp + 12], s17
	mov  long [sp + 16], lr

	mov  s17, a0 ;trampolines expect trapframe in s17

	mov  t1, long [a0 + OSContext_t0]
	beq  t1, .sysout

	mov  t0, long [OSCallCount]
	slt  t0, t0, t1
	bne  t0, .sysout

	la   t0, OSCallTable
	mov  t0, long [t0 + t1 LSH 2]

	jalr lr, t0, 0

.sysout:
	mov  lr, long [sp + 16]
	mov  s17, long [sp + 12]
	mov  s1, long [sp + 8]
	mov  s0, long [sp + 4]
	addi sp, sp, 20

	ret

.section INIT$text

KiXr17032Init:
.global KiXr17032Init
	mfcr t1, eb
	mov  long [HALXr17032SavedEV], t1, tmp=t0

	mtcr eb, a0

	mtcr ebadaddr, zero

	j    HALXr17032TLBFlushAll

.section text

KeIPLCurrentGet:
.global KeIPLCurrentGet
	mov  a3, long [KeIPLCurrent]
	ret

; don't let HALXr17032MapSwitch cross a page boundary or bad things might
; happen if there's a TLB miss in the middle

.align 128

; MUST BE CALLED WITH INTERRUPTS DISABLED
; asid pgtb --
HALXr17032MapSwitch:
.global HALXr17032MapSwitch
	; set the new page directory in TLB entry 0

	mfcr t1, itbindex
	mfcr t2, dtbindex

	mtcr itbindex, zero
	mtcr dtbindex, zero

	la   t0, PAGEDIRECTORY
	rshi t0, t0, 12
	mtcr itbtag, t0
	mtcr dtbtag, t0

	mov  t0, a0
	rshi t0, t0, 12
	lshi t0, t0, 5
	ori  t0, t0, 0x17
	mtcr itbpte, t0
	mtcr dtbpte, t0

	mtcr itbindex, t1
	mtcr dtbindex, t2

	; set the asid

	lshi a1, a1, 20
	mtcr itbtag, a1
	mtcr dtbtag, a1

	ret

.section text
