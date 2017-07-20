	.global strLen
	.global plus_asm

strLen:
	mov.w	#0, R13
strLen_loop:
	mov.w	@R12+, R14
	tst.w	R14
	jeq strLen_ret
	add.w	#1, R13
	jmp strLen_loop
strLen_ret:
	mov.w 	R13, R12
	reta

plus_asm:
	add.w	R13, R12
	add.w	R14, R12
	reta
