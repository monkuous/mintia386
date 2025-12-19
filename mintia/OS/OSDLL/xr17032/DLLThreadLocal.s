;
; Implements the interlocked OSFastMutex for the xr17032 architecture, along
; with several other synchronization and thread-local features.
;

.section text

.extern DLLFastMutexWait
.extern DLLFastMutexWake

;fastmutex --
OSFastMutexAcquire:
.global OSFastMutexAcquire
	addi t0, a0, 4

.inc:
	mov  t1, locked [t0]
	addi t1, t1, 1
	sc   t2, [t0], t1
	beq  t2, .inc

	mov  t3, long [tp + 0]
	bne  t1, .notowned

	mov  long [a0 + 12], t3
	mov  long [a0 + 16], 1

	ret

.notowned:
	mov  t4, long [a0 + 12]
	sub  t4, t4, t3
	bne  t4, .wait

	mov  t4, long [a0 + 16]
	addi t4, t4, 1
	mov  long [a0 + 16], t4

	ret

.wait:
	subi sp, sp, 8
	mov  long [sp], lr
	mov  long [sp + 4], a0

	jal  DLLFastMutexWait

	mov  a0, long [sp + 4]
	mov  lr, long [sp]
	addi sp, sp, 8

	mov  t3, long [tp + 0]
	mov  long [a0 + 12], t3
	mov  long [a0 + 16], 1

	ret

;fastmutex --
OSFastMutexRelease:
.global OSFastMutexRelease
	addi t0, a0, 4

	mov  t4, long [a0 + 16]
	subi t4, t4, 1
	mov  long [a0 + 16], t4
	bne  t4, .stillowned

	mov  long [a0 + 12], zero

.dec:
	mov  t3, locked [t0]
	subi t3, t3, 1
	sc   t2, [t0], t3
	beq  t2, .dec

	blt  t3, .done

	subi sp, sp, 4
	mov  long [sp], lr

	jal  DLLFastMutexWake

	mov  lr, long [sp]
	addi sp, sp, 4
	ret

.stillowned:

.dec2:
	mov  t3, locked [t0]
	subi t3, t3, 1
	sc   t2, [t0], t3
	beq  t2, .dec2

.done:
	ret

;fastmutex -- acquired
OSFastMutexTryAcquire:
.global OSFastMutexTryAcquire
	addi t0, a0, 4

.try:
	mov  t3, locked [t0]
	bge  t3, .contended
	sc   t2, [t0], zero
	beq  t2, .try

	mov  t3, long [tp + 0]
	mov  long [a0 + 12], t3
	mov  long [a0 + 16], 1

	li   a3, 1
	ret

.contended:
	li   a3, 0
	ret

; shove this stuff in here because why not

; inc ptr -- oldcount
OSInterlockedIncrement:
.global OSInterlockedIncrement
.inc:
	mov  t0, locked [a0]
	add  t1, t0, a1
	sc   t1, [a0], t1
	beq  t1, .inc

	mov  a3, t0

	ret

; -- teb
OSThreadCurrentTEB:
.global OSThreadCurrentTEB
	mov  a3, tp
	ret

; -- tid
OSThreadCurrentTID:
.global OSThreadCurrentTID
	mov  a3, long [tp + 0]
	ret
