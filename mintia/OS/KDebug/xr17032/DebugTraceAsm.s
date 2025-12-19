.section text

.extern DebugLink

GetLink:
.global GetLink
	mov  long [DebugLink], sp, tmp=t0
	ret
