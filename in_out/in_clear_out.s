.global _main
.align 4


.macro address buf
	adrp x1, \buf@page
	add x1, x1, \buf@pageoff
.endmacro


.macro input buf
	mov x0, #0
	address \buf
	mov x2, #8
	mov x16, #3
	svc #128
.endmacro

.macro print buf
	mov x0, #1
	adrp x1, \buf@page
	add x1,x1,\buf@pageoff
	mov x2, #8
	mov x16, #4
	svc #128

.endmacro
.macro clear buf
	mov x14, #0
	address \buf
loop:
	mov x2, #0
	str x2, [x1]
	add x14, x14, #1
	cmp x14, #8
	blt loop
.endmacro

_main:
	input buffer
	print buffer
	
	clear buffer
	
	input buffer
	print buffer

	mov x16, #1
	svc #128
.data
string: .ascii "hi\n"
buffer: .fill 8 + 1, 1, 0
