.section text

;a1 - dividend
;a0 - divisor
signeddiv:
.global signeddiv
	div signed a3, a1, a0
	ret
