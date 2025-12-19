.extern a3xMalloc
.extern a3xCalloc
.extern a3xFree
.extern a3xPuts
.extern a3xGets
.extern a3xPutc
.extern a3xGetc

; hack to keep names pretty

.section text

; sz -- ptr
Malloc:
.global Malloc
	j a3xMalloc

; sz -- ptr
Calloc:
.global Calloc
	j a3xCalloc

; ptr --
Free:
.global Free
	j a3xFree

; str --
Puts:
.global Puts
	j a3xPuts

; buf maxchars --
Gets:
.global Gets
	j a3xGets

; c --
Putc:
.global Putc
	j a3xPutc

; -- c
Getc:
.global Getc
	j a3xGetc
