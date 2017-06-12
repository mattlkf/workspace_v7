;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.

;	int a[5] = {0,1,2,3,4};
	.global	a
	.sect	".data:a", RW
	.clink
	.align	2
	.elfsym	a,SYM_SIZE(10)

a:
	.bits	1,16			; a[0] @ 0
	.bits	2,16			; a[1] @ 16
	.bits	3,16			; a[2] @ 32
	.bits	4,16			; a[3] @ 48
	.bits	5,16			; a[4] @ 64
	.bits	1,16			; a[0] @ 0
	.bits	2,16			; a[1] @ 16
	.bits	3,16			; a[2] @ 32
	.bits	4,16			; a[3] @ 48
	.bits	5,16			; a[4] @ 64

;	int b[5] = {5,6,7,8,9};
	.global	b
	.sect	".data:b", RW
	.clink
	.align	2
	.elfsym	b,SYM_SIZE(10)
b:
	.bits	6,16			; b[0] @ 0
	.bits	7,16			; b[1] @ 16
	.bits	8,16			; b[2] @ 32
	.bits	9,16			; b[3] @ 48
	.bits	10,16			; b[4] @ 64
	.bits	6,16			; b[0] @ 0
	.bits	7,16			; b[1] @ 16
	.bits	8,16			; b[2] @ 32
	.bits	9,16			; b[3] @ 48
	.bits	10,16			; b[4] @ 64

;	int c[10];
	.global	c
	.common	c,20,2

MPY_OP1		.equ	0x04C0
MAC_OP1		.equ	0x04C4 	; first operand for multiply-accumulate
MPY_OP2		.equ	0x04C8
RESULT		.equ	0x04CA
RESULT_FPT	.equ	0x04CB	; nope, cannot read word across boundaries


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
;			Set up the DMA destination registers
;			Lower-priority channel (b) controls the multiplier
			mov.w	#MPY_OP2, &DMA1DAL
			mov.w	#0, &DMA1DAH
;			Set the size of the transfer: for now, do everything
			mov.w	#9, &DMA1SZ


;			Set up the DMA triggers (see table 6-12 in datasheet)
;			Both channels are triggered by Hardware Multiply
			mov.w	#DMA1TSEL_29, &DMACTL0

;			Set control bits for both channels:
;				- repeated single mode transfer
;				- destination no change
;				- source increment
;				- word to word transfers
;			mov.w	#DMADT_4+DMADSTINCR_0+DMASRCINCR_3+DMASWDW+DMAEN, &DMA0CTL
;			mov.w	#DMADT_4+DMADSTINCR_0+DMASRCINCR_3+DMASWDW+DMAEN, &DMA1CTL
			mov.w	#DMADT_4+DMADSTINCR_0+DMASRCINCR_3+DMASWDW, &DMA1CTL


;			Clear the MPY and R4 and first element of c
			mov.w   #100, R4 ; k

			mov.w	#0, R15
			mov.w	#0, R14
			mov.w	#0, R13
			mov.w	#0, R12
			mov.w	#0, R11
			mov.w	#0, R10
			mov.w	#0, R9
			mov.w	#0, R8
			mov.w	#0, R7


KERNEL:

;			Set up DMA source registers
;			mov.w	#RESULT, &DMA0SAL
            mov.w	#a, &DMA1SAL
            mov.w	#0, &DMA1SAH

            mov.w   #RESULT, R6

			mov.w	b(R5), &MPY_OP1		; load new OP1


;			mov.w	#DMA0TSEL_29+DMA1TSEL_0, &DMACTL0

;			Trigger the process by multiplying 0x0. This clears the accumulator
;			and causes the MPY DMA trigger to occur
;
;			mov.w	#10, &MPY_OP1
;			bis.w	#DMAREQ, &DMA1CTL

;			mov.w	#0xF001, &MPY_OP1
;			mov.w	#0, &MPY_OP2
			bis.w	#DMAEN, &DMA1CTL	; enable DMA
			mov.w	#0, &MPY_OP2		; trigger DMA

			nop
			nop
			nop

			add.w	&RESULT, R15		; 5 cycles
			add.w	&RESULT, R14		; 5 cycles
			add.w	&RESULT, R13		; 5 cycles

			add.w	&RESULT, R12
			add.w	&RESULT, R11
			add.w	&RESULT, R10		;
			add.w	&RESULT, R9			; 5
			add.w	&RESULT, R8			; 5
			add.w	&RESULT, R7			; 5
			bic.w	#DMAEN,	&DMA1CTL 	; disable DMA

			sub.w 	#1, R4
			jnz    KERNEL


;			mov.w 	a+2(R5), &MPY_OP1	; load new OP1
;			bis.w	#DMAEN, &DMA1CTL	; enable DMA
;			mov.w	#0, &MPY_OP2		; trigger DMA
;			nop							; warm-up time
;			nop
;			nop

;			add.w	&RESULT, R12
;			add.w	&RESULT, R11
;			add.w	&RESULT, R10
;			bic.w	#DMAEN,	&DMA1CTL 	; disable DMA

;			mov.w	a+4(R5), &MPY_OP1	; load new OP1
;			bis.w	#DMAEN, &DMA1CTL	; enable DMA
;			mov.w	#0, &MPY_OP2		; trigger DMA
;			nop							; warm-up time
;			nop
;			nop
;			add.w	&RESULT, R9
;			add.w	&RESULT, R8
;			add.w	&RESULT, R7
;			bic.w	#DMAEN, &DMA1CTL 	; disable DMA
			mov.w   #c, R6

			MOV.W R7, 0(R6)
			MOV.W R8, 2(R6)
			MOV.W R9, 4(R6)
			MOV.W R10, 12(R6)
			MOV.W R11, 14(R6)
			MOV.W R12, 16(R6)
			MOV.W R13, 24(R6)
			MOV.W R14, 26(R6)
			MOV.W R15, 28(R6)

			nop

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
            
