	.global strLen
	.global plus_asm
	.global self_modifying_code
	.global asm_func
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
	ret

plus_asm:
	add.w	R13, R12
	add.w	R14, R12
	ret

self_modifying_code:
	; Read in an argument, return that argument.. via a move
	mov.w 	#2, &(modify_mov + 2)
	nop
	nop
	nop
modify_mov:
	mov.w	#5, R12
	ret

; test if a stack variable can be directly used as a loop counter
asm_func:
	mov.w	#0, R15

	add.w	#2, SP
	mov.w	R12, 0(SP)
	tst		0(SP)
	jz		loop_end
loop_head:
	add.w	#1, R15
	nop
	sub.w	#1, 0(SP)
	jnz		loop_head

loop_end:
	nop
	sub.w	#2, SP
	ret
