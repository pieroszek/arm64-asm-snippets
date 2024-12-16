.global _main
.align 4


.macro input buffer
	mov x0, #0
	adrp x1, \buffer@page
	add x1, x1, \buffer@pageoff
	mov x2, #8
	mov x16, #3
	svc #128
.endmacro

.macro output buffer
	mov x0, #1
	adrp x1, \buffer@page
	add x1, x1, \buffer@pageoff
	mov x2, #8
	mov x16, #4
	svc #128
.endmacro


.macro eof
	mov x16, #1
	svc #128
.endmacro

_main:
	input buffer
	
	output buffer

	eof



.data
buffer: .fill 8 + 1,1,0 
