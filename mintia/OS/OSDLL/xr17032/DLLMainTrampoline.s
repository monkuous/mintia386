.extern OSExit
.extern OSThreadExit
.extern DLLMainHL

.section text

; copy arguments table from OSPEB to stack and jump to entrypoint
; does not return

DLLMain:
.global DLLMain
	subi sp, sp, 4
	mov  long [sp], zero

	jal DLLMainHL
	nop

;a2 - program entry
;a1 - argv
;a0 - argc
DLLMainTrampoline:
.global DLLMainTrampoline
	subi sp, sp, 4
	mov  long [sp], zero

	jalr lr, a2, 0

	mov  a0, a3
	j    OSExit

DLLThreadExit:
.global DLLThreadExit
	mov  a0, a3
	j    OSThreadExit

.extern DLLSignalDispatchHL
.extern DLLAPCDispatchHL

DLLSignalDispatch:
.global DLLSignalDispatch
	mov  t0, long [sp + 116]
	mov  t1, long [sp + 124]
	mov  t2, long [sp + 128]

	subi sp, sp, 12
	mov  long [sp], t0
	mov  long [sp + 4], t1
	mov  long [sp + 8], t2

	jal  DLLSignalDispatchHL
	nop

DLLAPCDispatch:
.global DLLAPCDispatch
	mov  t0, long [sp + 116]
	mov  t1, long [sp + 124]
	mov  t2, long [sp + 128]

	subi sp, sp, 12
	mov  long [sp], t0
	mov  long [sp + 4], t1
	mov  long [sp + 8], t2

	jal  DLLAPCDispatchHL
	nop

.section data

nonsense:
	.dl 0

.section bss

nonsense2:
	.dl 0
