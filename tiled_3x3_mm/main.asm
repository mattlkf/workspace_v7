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

MPY_OP1		.equ	0x04C0
MAC_OP1		.equ	0x04C4 	; first operand for multiply-accumulate
MPY_OP2		.equ	0x04C8
RESULT		.equ	0x04CA


;	int a[5] = {0,1,2,3,4};
	.global	a
	.sect	".data:a", RW
	.clink
	.align	2
	.elfsym	a,SYM_SIZE(10)
a:
			.bits 3,16
			.bits 6,16
			.bits 7,16
			.bits 5,16
			.bits 3,16
			.bits 5,16
			.bits 6,16
			.bits 2,16
			.bits 9,16
			.bits 1,16
			.bits 2,16
			.bits 7,16
			.bits 0,16
			.bits 9,16
			.bits 3,16
			.bits 6,16
			.bits 0,16
			.bits 6,16
			.bits 2,16
			.bits 6,16
			.bits 1,16
			.bits 8,16
			.bits 7,16
			.bits 9,16
			.bits 2,16
			.bits 0,16
			.bits 2,16
			.bits 3,16
			.bits 7,16
			.bits 5,16
			.bits 9,16
			.bits 2,16
			.bits 2,16
			.bits 8,16
			.bits 9,16
			.bits 7,16
			.bits 3,16
			.bits 6,16
			.bits 1,16
			.bits 2,16
			.bits 9,16
			.bits 3,16
			.bits 1,16
			.bits 9,16
			.bits 4,16
			.bits 7,16
			.bits 8,16
			.bits 4,16
			.bits 5,16
			.bits 0,16
			.bits 3,16
			.bits 6,16
			.bits 1,16
			.bits 0,16
			.bits 6,16
			.bits 3,16
			.bits 2,16
			.bits 0,16
			.bits 6,16
			.bits 1,16
			.bits 5,16
			.bits 5,16
			.bits 4,16
			.bits 7,16
			.bits 6,16
			.bits 5,16
			.bits 6,16
			.bits 9,16
			.bits 3,16
			.bits 7,16
			.bits 4,16
			.bits 5,16
			.bits 2,16
			.bits 5,16
			.bits 4,16
			.bits 7,16
			.bits 4,16
			.bits 4,16
			.bits 3,16
			.bits 0,16
			.bits 7,16
			.bits 8,16
			.bits 6,16
			.bits 8,16
			.bits 8,16
			.bits 4,16
			.bits 3,16
			.bits 1,16
			.bits 4,16
			.bits 9,16

;	int b[5] = {5,6,7,8,9};
	.global	b
	.sect	".data:b", RW
	.clink
	.align	2
	.elfsym	b,SYM_SIZE(10)
b:
			.bits 2,16
			.bits 0,16
			.bits 6,16
			.bits 8,16
			.bits 9,16
			.bits 2,16
			.bits 6,16
			.bits 6,16
			.bits 4,16
			.bits 9,16
			.bits 5,16
			.bits 0,16
			.bits 4,16
			.bits 8,16
			.bits 7,16
			.bits 1,16
			.bits 7,16
			.bits 2,16
			.bits 7,16
			.bits 2,16
			.bits 2,16
			.bits 6,16
			.bits 1,16
			.bits 0,16
			.bits 6,16
			.bits 1,16
			.bits 5,16
			.bits 9,16
			.bits 4,16
			.bits 9,16
			.bits 0,16
			.bits 9,16
			.bits 1,16
			.bits 7,16
			.bits 7,16
			.bits 1,16
			.bits 1,16
			.bits 5,16
			.bits 9,16
			.bits 7,16
			.bits 7,16
			.bits 6,16
			.bits 7,16
			.bits 3,16
			.bits 6,16
			.bits 5,16
			.bits 6,16
			.bits 3,16
			.bits 9,16
			.bits 4,16
			.bits 8,16
			.bits 1,16
			.bits 2,16
			.bits 9,16
			.bits 3,16
			.bits 9,16
			.bits 0,16
			.bits 8,16
			.bits 8,16
			.bits 5,16
			.bits 0,16
			.bits 9,16
			.bits 6,16
			.bits 3,16
			.bits 8,16
			.bits 5,16
			.bits 6,16
			.bits 1,16
			.bits 1,16
			.bits 5,16
			.bits 9,16
			.bits 8,16
			.bits 4,16
			.bits 8,16
			.bits 1,16
			.bits 0,16
			.bits 3,16
			.bits 0,16
			.bits 4,16
			.bits 4,16
			.bits 4,16
			.bits 4,16
			.bits 7,16
			.bits 6,16
			.bits 3,16
			.bits 1,16
			.bits 7,16
			.bits 5,16
			.bits 9,16
			.bits 6,16

;	int c[4];
	.global	c
	.common	c,72,2

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

; Decrement stack pointer to allocate space for stack-stored local variables


;			MOV.W	&a, R4	; pointer to sliver of A
;			MOV.W	&b, R5	; pointer to sliver of B
;
;			MOV.W	&c,	R6	; pointer to C

			; loop 1
;			MOV.W 	#8, R6
;loop1:
;			MOV.W 	a(R6),R5
;			SUB.W	#2,R6
;			JNZ		loop1
;			NOP

			MOV.W #c+42, R6
			MOV.W #12, R4
loop_a:
			MOV.W #12, R5
loop_b:

;			k = 0
			MOV.W #a, R4
			MOV.W #b, R5
			MOV.W #RESULT, R6

;			mov.w	@R4,R4

			MOV.W @R4+, &MPY_OP1
			MOV.W @R5+, &MPY_OP2
;			MOV.W a-6(R4), &MPY_OP1
;			MOV.W b-6(R5), &MPY_OP2

			mov.w @R6, R7
;			MOV.W &RESULT, R7
			MOV.W b-4(R5), &MPY_OP2
			MOV.W &RESULT, R8
			MOV.W b-2(R5), &MPY_OP2
			MOV.W &RESULT, R9
			MOV.W a-4(R4), &MPY_OP1
			MOV.W b-6(R5), &MPY_OP2
			MOV.W &RESULT, R10
			MOV.W b-4(R5), &MPY_OP2
			MOV.W &RESULT, R11
			MOV.W b-2(R5), &MPY_OP2
			MOV.W &RESULT, R12
			MOV.W a-2(R4), &MPY_OP1
			MOV.W b-6(R5), &MPY_OP2
			MOV.W &RESULT, R13
			MOV.W b-4(R5), &MPY_OP2
			MOV.W &RESULT, R14
			MOV.W b-2(R5), &MPY_OP2
			MOV.W &RESULT, R15

;			k = 1
			MOV.W a+6(R4), &MPY_OP1
			MOV.W b+6(R5), &MPY_OP2
			ADD.W &RESULT, R7
			MOV.W b+8(R5), &MPY_OP2
			ADD.W &RESULT, R8
			MOV.W b+10(R5), &MPY_OP2
			ADD.W &RESULT, R9
			MOV.W a+8(R4), &MPY_OP1
			MOV.W b+6(R5), &MPY_OP2
			ADD.W &RESULT, R10
			MOV.W b+8(R5), &MPY_OP2
			ADD.W &RESULT, R11
			MOV.W b+10(R5), &MPY_OP2
			ADD.W &RESULT, R12
			MOV.W a+10(R4), &MPY_OP1
			MOV.W b+6(R5), &MPY_OP2
			ADD.W &RESULT, R13
			MOV.W b+8(R5), &MPY_OP2
			ADD.W &RESULT, R14
			MOV.W b+10(R5), &MPY_OP2
			ADD.W &RESULT, R15

;			k = 2
			MOV.W a+18(R4), &MPY_OP1
			MOV.W b+18(R5), &MPY_OP2
			ADD.W &RESULT, R7
			MOV.W b+20(R5), &MPY_OP2
			ADD.W &RESULT, R8
			MOV.W b+22(R5), &MPY_OP2
			ADD.W &RESULT, R9
			MOV.W a+20(R4), &MPY_OP1
			MOV.W b+18(R5), &MPY_OP2
			ADD.W &RESULT, R10
			MOV.W b+20(R5), &MPY_OP2
			ADD.W &RESULT, R11
			MOV.W b+22(R5), &MPY_OP2
			ADD.W &RESULT, R12
			MOV.W a+22(R4), &MPY_OP1
			MOV.W b+18(R5), &MPY_OP2
			ADD.W &RESULT, R13
			MOV.W b+20(R5), &MPY_OP2
			ADD.W &RESULT, R14
			MOV.W b+22(R5), &MPY_OP2
			ADD.W &RESULT, R15

;			k = 3
			MOV.W a+30(R4), &MPY_OP1
			MOV.W b+30(R5), &MPY_OP2
			ADD.W &RESULT, R7
			MOV.W b+32(R5), &MPY_OP2
			ADD.W &RESULT, R8
			MOV.W b+34(R5), &MPY_OP2
			ADD.W &RESULT, R9
			MOV.W a+32(R4), &MPY_OP1
			MOV.W b+30(R5), &MPY_OP2
			ADD.W &RESULT, R10
			MOV.W b+32(R5), &MPY_OP2
			ADD.W &RESULT, R11
			MOV.W b+34(R5), &MPY_OP2
			ADD.W &RESULT, R12
			MOV.W a+34(R4), &MPY_OP1
			MOV.W b+30(R5), &MPY_OP2
			ADD.W &RESULT, R13
			MOV.W b+32(R5), &MPY_OP2
			ADD.W &RESULT, R14
			MOV.W b+34(R5), &MPY_OP2
			ADD.W &RESULT, R15

;			k = 4
			MOV.W a+42(R4), &MPY_OP1
			MOV.W b+42(R5), &MPY_OP2
			ADD.W &RESULT, R7
			MOV.W b+44(R5), &MPY_OP2
			ADD.W &RESULT, R8
			MOV.W b+46(R5), &MPY_OP2
			ADD.W &RESULT, R9
			MOV.W a+44(R4), &MPY_OP1
			MOV.W b+42(R5), &MPY_OP2
			ADD.W &RESULT, R10
			MOV.W b+44(R5), &MPY_OP2
			ADD.W &RESULT, R11
			MOV.W b+46(R5), &MPY_OP2
			ADD.W &RESULT, R12
			MOV.W a+46(R4), &MPY_OP1
			MOV.W b+42(R5), &MPY_OP2
			ADD.W &RESULT, R13
			MOV.W b+44(R5), &MPY_OP2
			ADD.W &RESULT, R14
			MOV.W b+46(R5), &MPY_OP2
			ADD.W &RESULT, R15

;			k = 5
			MOV.W a+54(R4), &MPY_OP1
			MOV.W b+54(R5), &MPY_OP2
			ADD.W &RESULT, R7
			MOV.W b+56(R5), &MPY_OP2
			ADD.W &RESULT, R8
			MOV.W b+58(R5), &MPY_OP2
			ADD.W &RESULT, R9
			MOV.W a+56(R4), &MPY_OP1
			MOV.W b+54(R5), &MPY_OP2
			ADD.W &RESULT, R10
			MOV.W b+56(R5), &MPY_OP2
			ADD.W &RESULT, R11
			MOV.W b+58(R5), &MPY_OP2
			ADD.W &RESULT, R12
			MOV.W a+58(R4), &MPY_OP1
			MOV.W b+54(R5), &MPY_OP2
			ADD.W &RESULT, R13
			MOV.W b+56(R5), &MPY_OP2
			ADD.W &RESULT, R14
			MOV.W b+58(R5), &MPY_OP2
			ADD.W &RESULT, R15

;			k = 6
			MOV.W a+66(R4), &MPY_OP1
			MOV.W b+66(R5), &MPY_OP2
			ADD.W &RESULT, R7
			MOV.W b+68(R5), &MPY_OP2
			ADD.W &RESULT, R8
			MOV.W b+70(R5), &MPY_OP2
			ADD.W &RESULT, R9
			MOV.W a+68(R4), &MPY_OP1
			MOV.W b+66(R5), &MPY_OP2
			ADD.W &RESULT, R10
			MOV.W b+68(R5), &MPY_OP2
			ADD.W &RESULT, R11
			MOV.W b+70(R5), &MPY_OP2
			ADD.W &RESULT, R12
			MOV.W a+70(R4), &MPY_OP1
			MOV.W b+66(R5), &MPY_OP2
			ADD.W &RESULT, R13
			MOV.W b+68(R5), &MPY_OP2
			ADD.W &RESULT, R14
			MOV.W b+70(R5), &MPY_OP2
			ADD.W &RESULT, R15

;			k = 7
			MOV.W a+78(R4), &MPY_OP1
			MOV.W b+78(R5), &MPY_OP2
			ADD.W &RESULT, R7
			MOV.W b+80(R5), &MPY_OP2
			ADD.W &RESULT, R8
			MOV.W b+82(R5), &MPY_OP2
			ADD.W &RESULT, R9
			MOV.W a+80(R4), &MPY_OP1
			MOV.W b+78(R5), &MPY_OP2
			ADD.W &RESULT, R10
			MOV.W b+80(R5), &MPY_OP2
			ADD.W &RESULT, R11
			MOV.W b+82(R5), &MPY_OP2
			ADD.W &RESULT, R12
			MOV.W a+82(R4), &MPY_OP1
			MOV.W b+78(R5), &MPY_OP2
			ADD.W &RESULT, R13
			MOV.W b+80(R5), &MPY_OP2
			ADD.W &RESULT, R14
			MOV.W b+82(R5), &MPY_OP2
			ADD.W &RESULT, R15

;			k = 8
			MOV.W a+90(R4), &MPY_OP1
			MOV.W b+90(R5), &MPY_OP2
			ADD.W &RESULT, R7
			MOV.W b+92(R5), &MPY_OP2
			ADD.W &RESULT, R8
			MOV.W b+94(R5), &MPY_OP2
			ADD.W &RESULT, R9
			MOV.W a+92(R4), &MPY_OP1
			MOV.W b+90(R5), &MPY_OP2
			ADD.W &RESULT, R10
			MOV.W b+92(R5), &MPY_OP2
			ADD.W &RESULT, R11
			MOV.W b+94(R5), &MPY_OP2
			ADD.W &RESULT, R12
			MOV.W a+94(R4), &MPY_OP1
			MOV.W b+90(R5), &MPY_OP2
			ADD.W &RESULT, R13
			MOV.W b+92(R5), &MPY_OP2
			ADD.W &RESULT, R14
			MOV.W b+94(R5), &MPY_OP2
			ADD.W &RESULT, R15

;			k = 9
			MOV.W a+102(R4), &MPY_OP1
			MOV.W b+102(R5), &MPY_OP2
			ADD.W &RESULT, R7
			MOV.W b+104(R5), &MPY_OP2
			ADD.W &RESULT, R8
			MOV.W b+106(R5), &MPY_OP2
			ADD.W &RESULT, R9
			MOV.W a+104(R4), &MPY_OP1
			MOV.W b+102(R5), &MPY_OP2
			ADD.W &RESULT, R10
			MOV.W b+104(R5), &MPY_OP2
			ADD.W &RESULT, R11
			MOV.W b+106(R5), &MPY_OP2
			ADD.W &RESULT, R12
			MOV.W a+106(R4), &MPY_OP1
			MOV.W b+102(R5), &MPY_OP2
			ADD.W &RESULT, R13
			MOV.W b+104(R5), &MPY_OP2
			ADD.W &RESULT, R14
			MOV.W b+106(R5), &MPY_OP2
			ADD.W &RESULT, R15

;			k = 10
			MOV.W a+114(R4), &MPY_OP1
			MOV.W b+114(R5), &MPY_OP2
			ADD.W &RESULT, R7
			MOV.W b+116(R5), &MPY_OP2
			ADD.W &RESULT, R8
			MOV.W b+118(R5), &MPY_OP2
			ADD.W &RESULT, R9
			MOV.W a+116(R4), &MPY_OP1
			MOV.W b+114(R5), &MPY_OP2
			ADD.W &RESULT, R10
			MOV.W b+116(R5), &MPY_OP2
			ADD.W &RESULT, R11
			MOV.W b+118(R5), &MPY_OP2
			ADD.W &RESULT, R12
			MOV.W a+118(R4), &MPY_OP1
			MOV.W b+114(R5), &MPY_OP2
			ADD.W &RESULT, R13
			MOV.W b+116(R5), &MPY_OP2
			ADD.W &RESULT, R14
			MOV.W b+118(R5), &MPY_OP2
			ADD.W &RESULT, R15

;			k = 11
			MOV.W a+126(R4), &MPY_OP1
			MOV.W b+126(R5), &MPY_OP2
			ADD.W &RESULT, R7
			MOV.W b+128(R5), &MPY_OP2
			ADD.W &RESULT, R8
			MOV.W b+130(R5), &MPY_OP2
			ADD.W &RESULT, R9
			MOV.W a+128(R4), &MPY_OP1
			MOV.W b+126(R5), &MPY_OP2
			ADD.W &RESULT, R10
			MOV.W b+128(R5), &MPY_OP2
			ADD.W &RESULT, R11
			MOV.W b+130(R5), &MPY_OP2
			ADD.W &RESULT, R12
			MOV.W a+130(R4), &MPY_OP1
			MOV.W b+126(R5), &MPY_OP2
			ADD.W &RESULT, R13
			MOV.W b+128(R5), &MPY_OP2
			ADD.W &RESULT, R14
			MOV.W b+130(R5), &MPY_OP2
			ADD.W &RESULT, R15

;			k = 12
			MOV.W a+138(R4), &MPY_OP1
			MOV.W b+138(R5), &MPY_OP2
			ADD.W &RESULT, R7
			MOV.W b+140(R5), &MPY_OP2
			ADD.W &RESULT, R8
			MOV.W b+142(R5), &MPY_OP2
			ADD.W &RESULT, R9
			MOV.W a+140(R4), &MPY_OP1
			MOV.W b+138(R5), &MPY_OP2
			ADD.W &RESULT, R10
			MOV.W b+140(R5), &MPY_OP2
			ADD.W &RESULT, R11
			MOV.W b+142(R5), &MPY_OP2
			ADD.W &RESULT, R12
			MOV.W a+142(R4), &MPY_OP1
			MOV.W b+138(R5), &MPY_OP2
			ADD.W &RESULT, R13
			MOV.W b+140(R5), &MPY_OP2
			ADD.W &RESULT, R14
			MOV.W b+142(R5), &MPY_OP2
			ADD.W &RESULT, R15

;			k = 13
			MOV.W a+150(R4), &MPY_OP1
			MOV.W b+150(R5), &MPY_OP2
			ADD.W &RESULT, R7
			MOV.W b+152(R5), &MPY_OP2
			ADD.W &RESULT, R8
			MOV.W b+154(R5), &MPY_OP2
			ADD.W &RESULT, R9
			MOV.W a+152(R4), &MPY_OP1
			MOV.W b+150(R5), &MPY_OP2
			ADD.W &RESULT, R10
			MOV.W b+152(R5), &MPY_OP2
			ADD.W &RESULT, R11
			MOV.W b+154(R5), &MPY_OP2
			ADD.W &RESULT, R12
			MOV.W a+154(R4), &MPY_OP1
			MOV.W b+150(R5), &MPY_OP2
			ADD.W &RESULT, R13
			MOV.W b+152(R5), &MPY_OP2
			ADD.W &RESULT, R14
			MOV.W b+154(R5), &MPY_OP2
			ADD.W &RESULT, R15

;			k = 14
			MOV.W a+162(R4), &MPY_OP1
			MOV.W b+162(R5), &MPY_OP2
			ADD.W &RESULT, R7
			MOV.W b+164(R5), &MPY_OP2
			ADD.W &RESULT, R8
			MOV.W b+166(R5), &MPY_OP2
			ADD.W &RESULT, R9
			MOV.W a+164(R4), &MPY_OP1
			MOV.W b+162(R5), &MPY_OP2
			ADD.W &RESULT, R10
			MOV.W b+164(R5), &MPY_OP2
			ADD.W &RESULT, R11
			MOV.W b+166(R5), &MPY_OP2
			ADD.W &RESULT, R12
			MOV.W a+166(R4), &MPY_OP1
			MOV.W b+162(R5), &MPY_OP2
			ADD.W &RESULT, R13
			MOV.W b+164(R5), &MPY_OP2
			ADD.W &RESULT, R14
			MOV.W b+166(R5), &MPY_OP2
			ADD.W &RESULT, R15
			MOV.W R7, 0(R6)
			MOV.W R8, 2(R6)
			MOV.W R9, 4(R6)
			MOV.W R10, 12(R6)
			MOV.W R11, 14(R6)
			MOV.W R12, 16(R6)
			MOV.W R13, 24(R6)
			MOV.W R14, 26(R6)
			MOV.W R15, 28(R6)

			SUB.W #6,R6
			SUB.W #6,R5
			JNZ loop_b

			SUB.W #24,R6
			SUB.W #6,R4
			JNZ loop_a


			NOP

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
            
