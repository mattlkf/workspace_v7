	.global	convolve_asm

; integer
MPY_OP1		.equ	0x04C0
MPY_OP2		.equ	0x04C8
RESULT		.equ	0x04CA

; fixed-point
Q15_OP1		.equ	0x04C2  ; first operand for signed multiply 16-bit
Q15_OP2		.equ	0x04C8	; second operand
Q15_RESULT	.equ 	0x04CC

MPY32CTL0	.equ 	0x04EC

convolve_asm:
	pushm.w	#7, 	R10 ; save all registers that we should not clobber
	sub.w	#44, 	SP ; make space for our locals

	; Initialize the stack values
	mov.w	4(R14), 0(SP)	; s[0] = out->z
	mov.w	R13,	2(SP)	; s[1] = kernels
	mov.w	6(R12), 4(SP)	; s[2] = in->val
	mov.w	0(R14), 6(SP)	; s[3] = out->x
							; s[4] used for oi
	mov.w	2(R14), 10(SP)	;
	sub.w	#1,		10(SP)	; s[5] = out->y - 1
							; s[6] used for oj
	mov.w	2(R14), 14(SP)	;
	and.w	#0xfff8,14(SP)	; s[7] = out->y & (~7)

	mov.w	2(R14), 16(SP)	;
	and.w	#7, 	16(SP)	; s[8] = out->y & 7

							; s[9] used for k
	mov.w	0(R14), R4
	sub.w	#1, 	R4		; R4 holds out->x-1
	mov.w	2(R12), &MPY_OP1; move in->y into operand 1
	mov.w	R4, 	&MPY_OP2; move (out->x - 1) into op 2
	mov.w	&RESULT,20(SP)	; s[10] = (out->x - 1) * in->y


	mov.w	0(R12), &MPY_OP2; in->x into op2
	mov.w	&RESULT,22(SP)	; s[11] = in->y * in->x

	mov.w	22(SP), &MPY_OP1
	mov.w	4(R12), &MPY_OP2
	mov.w	&RESULT,R4		; R4 holds in->z * s[11]
	mov.w 	#1, 	R5
	sub.w	R4,		R5 		; R5 = 1 - in->z * s[11]
	mov.w	R5, 	26(SP)	; s[13] = 1 - in-z * s[11]
	add.w	#7, 	R5
	mov.w	R5, 	24(SP)	; s[12] = 8 - in->z * s[11]

	mov.w	2(R12), R4		; R4 holds in->y
	sub.w	2(R14), R4		; R4 = in->y - out->y
	mov.w	R4, 	28(SP)	; s[14] = in->y - out->y

	mov.w	4(R13), 30(SP)	; s[15] = kernels[0]->z
	mov.w	0(R13), 32(SP)	; s[16] = kernels[0]->x
	mov.w	2(R13), 34(SP)	; s[17] = kernels[0]->y
							; s[18], s[19] reserved for bias and val
	mov.w	6(R12), 40(SP)	; s[20] = in->val
	mov.w	6(R14), 42(SP)	; s[20] = in->val


; Correct for the fact that words are two bytes
	rla.w	10(SP)
	rla.w	20(SP)
	rla.w	24(SP)
	rla.w	26(SP)
	rla.w	28(SP)

	; Turn on the fractional mode for the MPY32
	bis.w	#4, &MPY32CTL0			; bit 2 is MPYFRAC

	; Outermost loop
loop_s0_head:
	mov.w	2(SP), 	R5
	mov.w	8(R5), 	36(SP); kernel bias
	mov.w	6(R5),	38(SP);	kernel val
	add.w	#10, 	R5
	mov.w	R5, 	2(SP); kernels++

	mov.w	40(SP), R14		; Set up input_ptr

	mov.w	6(SP), 	8(SP)	; s[4] = s[3]
loop_s4_head:

	mov.w	14(SP), 12(SP)	; s[6] = s[7]
loop_s6_head:
	; Add the kernel bias to all our accumulators
	mov.w	36(SP), R4
	mov.w 	R4, 	R5
 	mov.w	R4, 	R6
  	mov.w 	R4, 	R7
  	mov.w 	R4, 	R8
  	mov.w 	R4, 	R9
  	mov.w 	R4, 	R10
  	mov.w	R4, 	R11
  	; Reset k_ptr to start of kernel
  	mov.w	38(SP), R15; 	k_ptr in R15

	mov.w	30(SP), 18(SP)
loop_s9_head:

	mov.w	32(SP), R12
loop_r12_head:

	mov.w	34(SP), R13
loop_r13_head:

	mov.w	@R15+,	&Q15_OP1	; move kernel elem into operand 1

	mov.w	@R14+, 	&Q15_OP2	; move input elem into operand 2
	add.w	&Q15_RESULT, R4

	mov.w	@R14+, 	&Q15_OP2
	add.w	&Q15_RESULT, R5

	mov.w	@R14+, 	&Q15_OP2
	add.w	&Q15_RESULT, R6

	mov.w	@R14+, 	&Q15_OP2
	add.w	&Q15_RESULT, R7

	mov.w	@R14+, 	&Q15_OP2
	add.w	&Q15_RESULT, R8

	mov.w	@R14+, 	&Q15_OP2
	add.w	&Q15_RESULT, R9

	mov.w	@R14+, 	&Q15_OP2
	add.w	&Q15_RESULT, R10

	mov.w	@R14+, 	&Q15_OP2
	add.w	&Q15_RESULT, R11


	sub.w	#14,		R14; 	in_ptr -= 7

	; End of R13 (j) loop
	sub.w	#1, 	R13
	jnz 	loop_r13_head

	add.w	10(SP), R14; 	in_ptr += s[5]

	; End of R12 (i) loop
	sub.w	#1, 	R12
	jnz		loop_r12_head

	add.w	20(SP),	R14;	in_ptr += s[10]

	; End of s[9] loop
	sub.w	#1, 	18(SP)
	jnz loop_s9_head

	; Load out_ptr into R12 since i is no longer in use
	mov.w	42(SP), R12

	mov.w 	R4,   	0(R12)
	mov.w 	R5,   	2(R12)
	mov.w 	R6,   	4(R12)
	mov.w 	R7,   	6(R12)
	mov.w 	R8,   	8(R12)
	mov.w 	R9,   	10(R12)
	mov.w 	R10,  	12(R12)
	mov.w 	R11,  	14(R12)

	add.w	#16, 	R12
	mov.w	R12, 	42(SP)

	add.w	24(SP), R14;	in_ptr += s[12];

; 	End of s[6] loop
	sub.w	#8, 	12(SP)
	jnz		loop_s6_head

;   Tail case

	mov.w	16(SP), R4
	tst.w	R4
	jz	loop_s4_body_end
	mov.w	R4, 12(SP)	; s[6] = s[8]

tail_loop_s6_head:
	; Add the kernel bias to all our accumulators
	mov.w	36(SP), R4

  	; Reset k_ptr to start of kernel
  	mov.w	38(SP), R15; 	k_ptr in R15

	mov.w	30(SP), 18(SP)
tail_loop_s9_head:

	mov.w	32(SP), R12
tail_loop_r12_head:

	mov.w	34(SP), R13
tail_loop_r13_head:

	mov.w	@R15+,	&Q15_OP1	; move kernel elem into operand 1

	mov.w	@R14+, 	&Q15_OP2	; move input elem into operand 2
	add.w	&Q15_RESULT, R4

	; End of R13 (j) loop
	sub.w	#1, 	R13
	jnz 	tail_loop_r13_head

	add.w	10(SP), R14; 	in_ptr += s[5]

	; End of R12 (i) loop
	sub.w	#1, 	R12
	jnz		tail_loop_r12_head

	add.w	20(SP),	R14;	in_ptr += s[10]

	; End of s[9] loop
	sub.w	#1, 	18(SP)
	jnz 	tail_loop_s9_head

	; Load out_ptr into R12 since i is no longer in use
	mov.w	42(SP), R12

	mov.w 	R4,   	0(R12)

	add.w	#2, 	R12
	mov.w	R12, 	42(SP)

	add.w	26(SP), R14;	in_ptr += s[13];

; 	End of s[6] tail loop
	sub.w	#1, 	12(SP)
	jnz		tail_loop_s6_head

loop_s4_body_end:

	add.w	28(SP), R14;	in_ptr += s[14]


;	End of s[4] loop
	sub.w	#1, 	8(SP)
	jnz		loop_s4_head

;	End of s[0] loop
	sub.w	#1,		0(SP)
	jnz		loop_s0_head

	nop
; Turn off the fractional mode for the MPY32
	bic.w	#4, &MPY32CTL0			; bit 2 is MPYFRAC


	add.w	#44, 	SP	; pop away local variables
	popm.w	#7, 	R10	; restore registers
	ret
