;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.

;-------------------------------------------------------------------------------

;	int a[5] = {0,1,2,3,4};
	.global	a
	.sect	".data:a", RW
	.clink
	.align	2
	.elfsym	a,SYM_SIZE(10)
a:
	.bits	3,16			; a[0] @ 0
	.bits	1,16			; a[1] @ 16
	.bits	2,16			; a[2] @ 32
	.bits	3,16			; a[3] @ 48
	.bits	4,16			; a[4] @ 64

;	int b[5] = {5,6,7,8,9};
	.global	b
	.sect	".data:b", RW
	.clink
	.align	2
	.elfsym	b,SYM_SIZE(10)
b:
	.bits	5,16			; b[0] @ 0
	.bits	6,16			; b[1] @ 16
	.bits	7,16			; b[2] @ 32
	.bits	8,16			; b[3] @ 48
	.bits	9,16			; b[4] @ 64

;	int c[4];
	.global	c
	.common	c,8,2


MPY_OP1		.equ	0x04C0
MAC_OP1		.equ	0x04C4 	; first operand for multiply-accumulate
MPY_OP2		.equ	0x04C8
RESULT		.equ	0x04CA


;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------


;-------------------------------------------------------------------------------
; 			Using mem-reg and reg-mem moves to do an inner product
;			42 cycles (expected) (5 * 8 + 2)
;			64 cycles (actual)
;-------------------------------------------------------------------------------


	        MOV.W	&a,R4
			MOV.W	R4,&MPY_OP1		; Load operand 1 into multiplier

	        MOV.W	&b,R4
			MOV.W	R4,&MPY_OP2		; Load operand 2 which triggers MPY

	        MOV.W	&a+2,R4
			MOV.W	R4,&MAC_OP1		; Load operand 1 into multiplier

	        MOV.W	&b+2,R4
			MOV.W	R4,&MPY_OP2		; Load operand 2 which triggers MPY

	        MOV.W	&a+4,R4
			MOV.W	R4,&MAC_OP1		; Load operand 1 into multiplier

	        MOV.W	&b+4,R4
			MOV.W	R4,&MPY_OP2		; Load operand 2 which triggers MPY

	        MOV.W	&a+6,R4
			MOV.W	R4,&MAC_OP1		; Load operand 1 into multiplier

	        MOV.W	&b+6,R4
			MOV.W	R4,&MPY_OP2		; Load operand 2 which triggers MPY

	        MOV.W	&a+8,R4
			MOV.W	R4,&MAC_OP1		; Load operand 1 into multiplier

	        MOV.W	&b+8,R4
			MOV.W	R4,&MPY_OP2		; Load operand 2 which triggers MPY

			MOV.W	&RESULT, R4		; Move result into return register

			NOP

;-------------------------------------------------------------------------------
;			Using memory-memory moves to do an inner product
;			42 cycles (expected)
;			54 cycles (actual)
;-------------------------------------------------------------------------------

	        MOV.W	&a,&MPY_OP1		; Load operand 1 into multiplier
	        MOV.W	&b,&MPY_OP2		; Load operand 2 which triggers MPY

	        MOV.W	&a+2,&MAC_OP1		; Load operand 1 into multiplier
	        MOV.W	&b+2,&MPY_OP2		; Load operand 2 which triggers MPY

	        MOV.W	&a+4,&MAC_OP1		; Load operand 1 into multiplier
	        MOV.W	&b+4,&MPY_OP2		; Load operand 2 which triggers MPY

	        MOV.W	&a+6,&MAC_OP1		; Load operand 1 into multiplier
	        MOV.W	&b+6,&MPY_OP2		; Load operand 2 which triggers MPY

	        MOV.W	&a+8,&MAC_OP1		; Load operand 1 into multiplier
	        MOV.W	&b+8,&MPY_OP2		; Load operand 2 which triggers MPY

			MOV.W	&RESULT, R4		; Move result into return register

			NOP
;-------------------------------------------------------------------------------
;			An outer product to compute a 4x4 tile of C (stored in registers)
;			 _____
;			|r4 r5|
;			|r6 r7|

;			41 cycles (actual) (not counting zeroing-out)
;-------------------------------------------------------------------------------

;			Zero out the tile
			BIC.W	R4,R4
			BIC.W	R5,R5
			BIC.W	R6,R6
			BIC.W	R7,R7

;			Upper-left
	        MOV.W	&b,&MPY_OP1
	        MOV.W	&a,&MPY_OP2
			ADD.W	&RESULT, R4

;			Lower-left (reuse b)
	        MOV.W	&a+2,&MPY_OP2
			ADD.W	&RESULT, R6

;			Upper-right
	        MOV.W	&b+2,&MPY_OP1
	        MOV.W	&a,&MPY_OP2
			ADD.W	&RESULT, R5

;			Lower-right (reuse b+2)
	        MOV.W	&a+2,&MPY_OP2
			ADD.W	&RESULT, R7

			NOP

;-------------------------------------------------------------------------------
;			An outer product to compute a 4x4 tile of C (stored in memory)
;			53 cycles (actual)
;-------------------------------------------------------------------------------

;			Upper-left
	        MOV.W	&b,&MPY_OP1
	        MOV.W	&a,&MPY_OP2
			ADD.W	&RESULT, &c

;			Lower-left (reuse b)
	        MOV.W	&a+2,&MPY_OP2
			ADD.W	&RESULT, &c+2

;			Upper-right
	        MOV.W	&b+2,&MPY_OP1
	        MOV.W	&a,&MPY_OP2
			ADD.W	&RESULT, &c+4

;			Lower-right (reuse b+2)
	        MOV.W	&a+2,&MPY_OP2
			ADD.W	&RESULT, &c+6

			NOP

;-------------------------------------------------------------------------------
;			An outer product to compute a 4x3 tile of C (tile stored in registers)
;			A and B are being read from memory all the time though
;			 ___________
;			|r4  r5  r6 |
;			|r7  r8  r9 |
;			|r10 r11 r12|
;			|r13 r14 r15|

;			107 cycles (actual) (for 12 multiplies --> 8.917 cycles per multiply)
;-------------------------------------------------------------------------------

;			First column (r4, r7, r10, r13), reusing b[0]
	        MOV.W	&b,&MPY_OP1
	        MOV.W	&a,&MPY_OP2
			ADD.W	&RESULT, R4

	        MOV.W	&a+2,&MPY_OP2
			ADD.W	&RESULT, R7

	        MOV.W	&a+4,&MPY_OP2
			ADD.W	&RESULT, R10

	        MOV.W	&a+6,&MPY_OP2
			ADD.W	&RESULT, R13


;			Second column (r5, r8, r11, r14), reusing b[1]
	        MOV.W	&b+2,&MPY_OP1
	        MOV.W	&a,&MPY_OP2
			ADD.W	&RESULT, R5

	        MOV.W	&a+2,&MPY_OP2
			ADD.W	&RESULT, R8

	        MOV.W	&a+4,&MPY_OP2
			ADD.W	&RESULT, R11

	        MOV.W	&a+6,&MPY_OP2
			ADD.W	&RESULT, R14

;			Third column (r6, r9, r12, r15), reusing b[2]
	        MOV.W	&b+4,&MPY_OP1
	        MOV.W	&a,&MPY_OP2
			ADD.W	&RESULT, R6

	        MOV.W	&a+2,&MPY_OP2
			ADD.W	&RESULT, R9

	        MOV.W	&a+4,&MPY_OP2
			ADD.W	&RESULT, R12

	        MOV.W	&a+6,&MPY_OP2
			ADD.W	&RESULT, R15

			NOP


;-------------------------------------------------------------------------------
;			An outer product to compute a 3x3 tile of C (tile stored in registers)
;			3 registers are used to store values from A
;			 ___________
;			|r4  r5  r6 |
;			|r7  r8  r9 |
;			|r10 r11 r12|

;			A[] : r13 r14 r15

;			77 cycles (actual) (for 9 multiplies --> 8.556 cycles per multiply)
;-------------------------------------------------------------------------------

;			Cache A in registers
			MOV.W 	&a,R13
			MOV.W 	&a+2,R14
			MOV.W	&a+4,R15

;			First column (r4, r7, r10), reusing b[0]
	        MOV.W	&b,&MPY_OP1
	        MOV.W	R13,&MPY_OP2
			ADD.W	&RESULT, R4

	        MOV.W	R14,&MPY_OP2
			ADD.W	&RESULT, R7

	        MOV.W	R15,&MPY_OP2
			ADD.W	&RESULT, R10

;			Second column (r5, r8, r11), reusing b[1]
	        MOV.W	&b+2,&MPY_OP1
	        MOV.W	R13,&MPY_OP2
			ADD.W	&RESULT, R5

	        MOV.W	R14,&MPY_OP2
			ADD.W	&RESULT, R8

	        MOV.W	R15,&MPY_OP2
			ADD.W	&RESULT, R11

;			Third column (r6, r9, r12), reusing b[2]
	        MOV.W	&b+4,&MPY_OP1
	        MOV.W	R13,&MPY_OP2
			ADD.W	&RESULT, R6

	        MOV.W	R14,&MPY_OP2
			ADD.W	&RESULT, R9

	        MOV.W	R15,&MPY_OP2
			ADD.W	&RESULT, R12

			NOP

;-------------------------------------------------------------------------------
;			Just trying to do some measurements
;-------------------------------------------------------------------------------

			MOV.W	&a,&c
			NOP
			MOV.W	&a,&c
			NOP
			NOP


			MOV.W	b,R4

			ADD.W	#256,R4

			MOV.W	-2(R5),R15

			MOV.W     a+0(r15),c+0(r13)     ; [] |28|

			NOP

;-------------------------------------------------------------------------------
;			A 4x3 kernel, using base+offset notation
;-------------------------------------------------------------------------------



;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
