; XXX has intricate knowledge of the implementation of lots of copy functions
; in terms of being sure that they wont corrupt saved registers.
; in dfrt these are all hand-written in asm so this can be known for sure.

.section text

.define MMHIGHESTUSERADDRESS 0x7FFEFFFF
.define KeThread_SafeAccessAbort 168
.define KeThread_SafeAccessSP 172
.define STATUS_FAULT -33
.define STATUS_FAULT_WRITE -100

.extern KeThreadCurrent
.extern _df_memcpy
.extern strncpy
.extern _df_memset

;a0 - sz
;a1 - src
;a2 - dest
;returns:
;a3 - 0 if success, STATUS_FAULT if fault
KeSafeCopyIn:
.global KeSafeCopyIn
	la   t0, MMHIGHESTUSERADDRESS
	slt  t1, t0, a1
	bne  t1, .failure

	subi sp, sp, 4
	mov  long [sp], lr

	la   t1, SafeAccessFailure
	mov  t0, long [KeThreadCurrent]
	mov  long [t0 + KeThread_SafeAccessAbort], t1
	mov  long [t0 + KeThread_SafeAccessSP], sp

	jal  _df_memcpy

	mov  t0, long [KeThreadCurrent]
	mov  long [t0 + KeThread_SafeAccessAbort], zero

	li   a3, 0

	mov  lr, long [sp]
	addi sp, sp, 4
	ret

.failure:
	la   a3, STATUS_FAULT
	ret

;a0 - sz
;a1 - src
;a2 - dest
;returns:
;a3 - 0 if success, STATUS_FAULT if fault
KeSafeCopyOut:
.global KeSafeCopyOut
	la   t0, MMHIGHESTUSERADDRESS
	slt  t1, t0, a2
	bne  t1, .failure

	subi sp, sp, 4
	mov  long [sp], lr

	la   t1, SafeAccessFailure
	mov  t0, long [KeThreadCurrent]
	mov  long [t0 + KeThread_SafeAccessAbort], t1
	mov  long [t0 + KeThread_SafeAccessSP], sp

	jal  _df_memcpy

	mov  t0, long [KeThreadCurrent]
	mov  long [t0 + KeThread_SafeAccessAbort], zero

	li   a3, 0

	mov  lr, long [sp]
	addi sp, sp, 4
	ret

.failure:
	la   a3, STATUS_FAULT_WRITE
	ret

;a0 - max
;a1 - src
;a2 - dest
;returns:
;a3 - 0 if success, STATUS_FAULT if fault
KeSafeStringCopyIn:
.global KeSafeStringCopyIn
	la   t0, MMHIGHESTUSERADDRESS
	slt  t1, t0, a1
	bne  t1, .failure

	subi sp, sp, 4
	mov  long [sp], lr

	la   t1, SafeAccessFailure
	mov  t0, long [KeThreadCurrent]
	mov  long [t0 + KeThread_SafeAccessAbort], t1
	mov  long [t0 + KeThread_SafeAccessSP], sp

	jal  strncpy

	mov  t0, long [KeThreadCurrent]
	mov  long [t0 + KeThread_SafeAccessAbort], zero

	li   a3, 0

	mov  lr, long [sp]
	addi sp, sp, 4
	ret

.failure:
	la   a3, STATUS_FAULT
	ret

;a0 - max
;a1 - src
;a2 - dest
;returns:
;a3 - 0 if success, STATUS_FAULT if fault
KeSafeStringCopyOut:
.global KeSafeStringCopyOut
	la   t0, MMHIGHESTUSERADDRESS
	slt  t1, t0, a2
	bne  t1, .failure

	subi sp, sp, 4
	mov  long [sp], lr

	la   t1, SafeAccessFailure
	mov  t0, long [KeThreadCurrent]
	mov  long [t0 + KeThread_SafeAccessAbort], t1
	mov  long [t0 + KeThread_SafeAccessSP], sp

	jal  strncpy

	mov  t0, long [KeThreadCurrent]
	mov  long [t0 + KeThread_SafeAccessAbort], zero

	li   a3, 0

	mov  lr, long [sp]
	addi sp, sp, 4
	ret

.failure:
	la   a3, STATUS_FAULT_WRITE
	ret

;a0 - word
;a1 - sz
;a2 - ptr
;returns:
;a3 - 0 if success, STATUS_FAULT if fault
KeSafeMemset:
.global KeSafeMemset
	la   t0, MMHIGHESTUSERADDRESS
	slt  t1, t0, a2
	bne  t1, .failure

	subi sp, sp, 4
	mov  long [sp], lr

	la   t1, SafeAccessFailure
	mov  t0, long [KeThreadCurrent]
	mov  long [t0 + KeThread_SafeAccessAbort], t1
	mov  long [t0 + KeThread_SafeAccessSP], sp

	jal  _df_memset

	mov  t0, long [KeThreadCurrent]
	mov  long [t0 + KeThread_SafeAccessAbort], zero

	li   a3, 0

	mov  lr, long [sp]
	addi sp, sp, 4
	ret

.failure:
	la   a3, STATUS_FAULT_WRITE
	ret

SafeAccessFailure:
	mov  t0, long [KeThreadCurrent]
	mov  long [t0 + KeThread_SafeAccessAbort], zero
	mov  sp, long [t0 + KeThread_SafeAccessSP]

	mov  a3, a0

	mov  lr, long [sp]
	addi sp, sp, 4
	ret

;a1 - byte
;a0 - dest
;returns:
;a3 - 0 if success, STATUS_FAULT if fault
KeSafeStoreByte:
.global KeSafeStoreByte
	la   t0, MMHIGHESTUSERADDRESS
	slt  t1, t0, a0
	bne  t1, .failure

	la   t1, SafeStoreByteFailure
	mov  t0, long [KeThreadCurrent]
	mov  long [t0 + KeThread_SafeAccessAbort], t1

	mov  byte [a0], a1

	mov  long [t0 + KeThread_SafeAccessAbort], zero

	li   a3, 0
	ret

.failure:
	la   a3, STATUS_FAULT_WRITE
	ret

SafeStoreByteFailure:
	mov  long [t0 + KeThread_SafeAccessAbort], zero
	mov  a3, a0
	ret

;a0 - dest
;returns:
;a3 - 0 if success, STATUS_FAULT if fault
KeSafeProbeWrite:
.global KeSafeProbeWrite
	la   t0, MMHIGHESTUSERADDRESS
	slt  t1, t0, a0
	bne  t1, .failure

	la   t1, SafeStoreByteFailure
	mov  t0, long [KeThreadCurrent]
	mov  long [t0 + KeThread_SafeAccessAbort], t1

	mov  t1, byte [a0]
	mov  byte [a0], t1

	mov  long [t0 + KeThread_SafeAccessAbort], zero

	li   a3, 0
	ret

.failure:
	la   a3, STATUS_FAULT_WRITE
	ret

;a0 - src
;returns:
;a3 - byte
;a2 - 0 if success, STATUS_FAULT if fault
KeSafeGetByte:
.global KeSafeGetByte
	la   t0, MMHIGHESTUSERADDRESS
	slt  t1, t0, a0
	bne  t1, .failure

	la   t1, SafeGetByteFailure
	mov  t0, long [KeThreadCurrent]
	mov  long [t0 + KeThread_SafeAccessAbort], t1

	mov  a3, byte [a0]

	mov  long [t0 + KeThread_SafeAccessAbort], zero

	li   a2, 0
	ret

.failure:
	la   a2, STATUS_FAULT
	ret

SafeGetByteFailure:
	mov  long [t0 + KeThread_SafeAccessAbort], zero

	mov  a2, a0
	ret

;a0 - src
;returns:
;a3 - byte
;a2 - 0 if success, STATUS_FAULT if fault
KeSafeProbeSystemByte:
.global KeSafeProbeSystemByte
	mov  t0, long [KeThreadCurrent]
	mov  t2, long [t0 + KeThread_SafeAccessAbort]

	la   t1, SafeGetSystemByteFailure
	mov  long [t0 + KeThread_SafeAccessAbort], t1

	mov  a3, byte [a0]

	mov  long [t0 + KeThread_SafeAccessAbort], t2

	li   a2, 0
	ret

SafeGetSystemByteFailure:
	mov  long [t0 + KeThread_SafeAccessAbort], t2

	mov  a2, a0
	ret

; inc ptr -- oldcount
KeInterlockedIncrement:
.global KeInterlockedIncrement
.inc:
	mov  t0, locked [a0]
	add  t1, t0, a1
	sc   t1, [a0], t1
	beq  t1, .inc

	mov  a3, t0

	ret
