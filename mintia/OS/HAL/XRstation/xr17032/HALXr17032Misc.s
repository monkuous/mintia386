; was once HALXr17032Exception.df until that stuff was moved into the kernel

.section text

; -- sp
HALCPUGetSP:
.global HALCPUGetSP
	mov  a3, sp
	ret

; -- rs
HALCPUInterruptDisable:
.global HALCPUInterruptDisable
	mfcr a3, rs
	subi t1, zero, 3
	and  t1, a3, t1 ; disable interrupts
	mtcr rs, t1
	ret

; rs --
HALCPUInterruptRestore:
.global HALCPUInterruptRestore
	mtcr rs, a0
	ret

; --
HALCPUInterruptEnable:
.global HALCPUInterruptEnable
	mfcr t0, rs
	ori  t0, t0, 2
	mtcr rs, t0
	ret

; old new --
HALCPUContextSwitch:
.global HALCPUContextSwitch
	subi sp, sp, 136

	mov  long [sp + 128], lr
	mov  long [sp + 40],  s0
	mov  long [sp + 44],  s1
	mov  long [sp + 48],  s2
	mov  long [sp + 52],  s3
	mov  long [sp + 56],  s4
	mov  long [sp + 60],  s5
	mov  long [sp + 64],  s6
	mov  long [sp + 68],  s7
	mov  long [sp + 72],  s8
	mov  long [sp + 76],  s9
	mov  long [sp + 80],  s10
	mov  long [sp + 84],  s11
	mov  long [sp + 88],  s12
	mov  long [sp + 92],  s13
	mov  long [sp + 96],  s14
	mov  long [sp + 100], s15
	mov  long [sp + 104], s16
	mov  long [sp + 108], s17
	mov  long [sp + 112], tp

	mov  long [a1], sp
	mov  sp, a0

	mov  s0,  long [sp + 40]
	mov  s1,  long [sp + 44]
	mov  s2,  long [sp + 48]
	mov  s3,  long [sp + 52]
	mov  s4,  long [sp + 56]
	mov  s5,  long [sp + 60]
	mov  s6,  long [sp + 64]
	mov  s7,  long [sp + 68]
	mov  s8,  long [sp + 72]
	mov  s9,  long [sp + 76]
	mov  s10, long [sp + 80]
	mov  s11, long [sp + 84]
	mov  s12, long [sp + 88]
	mov  s13, long [sp + 92]
	mov  s14, long [sp + 96]
	mov  s15, long [sp + 100]
	mov  s16, long [sp + 104]
	mov  s17, long [sp + 108]
	mov  tp,  long [sp + 112]
	mov  lr,  long [sp + 128]

	addi sp, sp, 136

	ret

;a0 - asid
;a1 - vpn
;a2 - pte
HALXr17032TLBFill:
.global HALXr17032TLBFill
	lshi t0, a1, 12
	mtcr itbctrl, t0
	mtcr dtbctrl, t0

	ret

HALXr17032TLBFlushAll:
.global HALXr17032TLBFlushAll
	li   t0, 2
	mtcr itbctrl, t0
	mtcr dtbctrl, t0

	ret

HALXr17032TLBFlush:
.global HALXr17032TLBFlush
	lshi t0, a1, 12
	mtcr itbctrl, t0
	mtcr dtbctrl, t0

	ret

HALDcacheExpunge:
.global HALDcacheExpunge
	wmb
	li   t0, 3
	mtcr dcachectrl, t0
	ret

HALIcacheSynchronize:
.global HALIcacheSynchronize
	wmb
	li   t0, 3
	mtcr icachectrl, t0
	ret

HALCPUFence:
.global HALCPUFence
	mb
	ret
