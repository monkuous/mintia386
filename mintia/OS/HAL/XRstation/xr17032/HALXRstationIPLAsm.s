.section text

.extern HALXRstationLSICBase
.extern HALInterruptStackTop
.extern HALInterruptNested
.extern HALXRstationIPLMasks
.extern HALPlatformInterruptHandlers
.extern KeIPLCurrent

HALInterrupt:
.global HALInterrupt
	subi sp, sp, 40
	mov  long [sp], lr
	mov  long [sp + 4], s0
	mov  long [sp + 8], s1
	mov  long [sp + 12], s2
	mov  long [sp + 16], s3
	mov  long [sp + 20], s4
	mov  long [sp + 24], s5
	mov  long [sp + 28], s6
	mov  long [sp + 32], s7
	mov  long [sp + 36], s8

	mov  s6, a0

	mov  s0, long [HALXRstationLSICBase]

	addi s8, s0, 16

	la   s7, HALInterruptStackTop
	mov  s7, long [s7]

	la   s5, HALInterruptNested

	la   s4, HALXRstationIPLMasks

	la   s1, HALPlatformInterruptHandlers

	la   s3, KeIPLCurrent
	mov  s2, long [s3]

.loop:
	mov  a0, long [s8]
	beq  a0, .done

	mov  long [s8], a0

	lshi t1, a0, 3
	add  t1, t1, s1

	mov  t2, long [t1]     ;get handler
	mov  t3, long [t1 + 4] ;get IPL

	mov  long [s3], t3

;inlined set LSIC mask

	lshi t3, t3, 3
	add  t3, t3, s4

	mov  t4, long [t3]
	mov  long [s0 + 4], t4

	mov  t4, long [t3 + 4]
	mov  long [s0 + 0], t4

;is this a nested interrupt?

	mov  t3, long [s5]
	bne  t3, .nested

;no it is not.

	mov  long [s5], 1

;call handler in context of interrupt stack

	mov  t0, sp
	mov  sp, s7

	subi sp, sp, 8
	mov  long [sp + 4], t0
	mov  long [sp], zero

	mfcr t0, rs
	ori  t0, t0, 2
	mtcr rs, t0

	mov  a1, s6
	jalr lr, t2, 0

	mfcr t0, rs
	subi t1, zero, 3
	and  t1, t0, t1
	mtcr rs, t1

	mov  sp, long [sp + 4]

	mov  long [s5], 0

	b .loop

.nested:

;inlined enable interrupts

	mfcr t0, rs
	ori  t0, t0, 2
	mtcr rs, t0

;call handler

	mov  a1, s6
	jalr lr, t2, 0

;inlined disable interrupts

	mfcr t0, rs
	subi t1, zero, 3
	and  t1, t0, t1
	mtcr rs, t1

	b    .loop

.done:
	mov  long [s3], s2

;inlined restore LSIC mask

	lshi t3, s2, 3
	add  t3, t3, s4

	mov  t4, long [t3]
	mov  long [s0 + 4], t4

	mov  t4, long [t3 + 4]
	mov  long [s0 + 0], t4

	mov  lr, long [sp]
	mov  s0, long [sp + 4]
	mov  s1, long [sp + 8]
	mov  s2, long [sp + 12]
	mov  s3, long [sp + 16]
	mov  s4, long [sp + 20]
	mov  s5, long [sp + 24]
	mov  s6, long [sp + 28]
	mov  s7, long [sp + 32]
	mov  s8, long [sp + 36]
	addi sp, sp, 40
	ret
