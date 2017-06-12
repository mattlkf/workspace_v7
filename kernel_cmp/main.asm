;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.

MPY_OP1		.equ	0x04C0
MAC_OP1		.equ	0x04C4 	; first operand for multiply-accumulate
MPY_OP2		.equ	0x04C8
RESULT		.equ	0x04CA
RESULT_FPT	.equ	0x04CB	; nope, cannot read word across boundaries

M2			.equ	36
N2			.equ	12
K			.equ	5
N_LOCALS	.equ	1

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
;			Prepare space on stack for local variables
			sub.w	#(2*N_LOCALS), SP

;			Configure DMA

;			Set up the DMA destination registers
			mov.w	#MPY_OP2, &DMA1DAL
			mov.w	#0, &DMA1DAH
;			Size of transfer = height of tile
			mov.w	#9, &DMA1SZ
;			Set up the DMA trigger to Hardware Multiply
			mov.w	#DMA1TSEL_29, &DMACTL0
;			Set control bits
			mov.w	#DMADT_4+DMADSTINCR_0+DMASRCINCR_3+DMASWDW, &DMA1CTL
;			Zero out source address high bits
            mov.w	#0, &DMA1SAH

;			loop across a
			mov.w	#a, R4
loop_guard_a:
			cmp.w	#a+M2, R4
			jeq 	loop_end_a

;			loop across b
			mov.w	#b, R5
loop_guard_b:
			cmp.w	#b+N2, R5
			jeq 	loop_end_b

;-------------------------------------------------------------------------------
; Initialize registers for kernel
;
;			Note: may get rid of this via MOV
;			instead of ADD in first kernel loop
;-------------------------------------------------------------------------------
			mov.w	#0, R15
			mov.w	#0, R14
			mov.w	#0, R13
			mov.w	#0, R12
			mov.w	#0, R11
			mov.w	#0, R10
			mov.w	#0, R9
			mov.w	#0, R8
			mov.w	#0, R7

			; Save R6 to the stack so we can use it for k
			mov.w	R6, 0(SP)
;-------------------------------------------------------------------------------
; Loop across k
;-------------------------------------------------------------------------------


;			jmp kernel_indirect ;<-- 2
			jmp kernel_dma;<--- 2
kernel_return:

;-------------------------------------------------------------------------------
; Write tile from registers to memory
;-------------------------------------------------------------------------------

			; Restore R6 from stack
			mov.w	0(SP), R6 ;<-- 2

			MOV.W R7,  (N2*0)(R6)
			MOV.W R8,  (N2*1)(R6)
			MOV.W R9,  (N2*2)(R6)
			MOV.W R10, (N2*3)(R6)
			MOV.W R11, (N2*4)(R6)
			MOV.W R12, (N2*5)(R6)
			MOV.W R13, (N2*6)(R6)
			MOV.W R14, (N2*7)(R6)
			MOV.W R15, (N2*8)(R6)

			add.w	#2, R6 ;9*1 tile

			add.w	#1*2, R5 ;9*1 tile
			jmp		loop_guard_b
loop_end_b:

			add.w	#(9*K*2 - 2*2),R6 ; 9*1 tile

			add.w	#9*2, R4 ;9*1 tile
			jmp		loop_guard_a
loop_end_a:
			nop


            ; Get rid of the local variables we declared
			add.w	#(2*N_LOCALS),SP

;-------------------------------------------------------------------------------
; Kernel 1: Using indirect auto increment mode
;-------------------------------------------------------------------------------

kernel_indirect:
			mov.w	#K, R6
kernel_indirect_loop_k:
			mov.w	@R5,	&MPY_OP1 ;<---3
			mov.w	@R4+, 	&MPY_OP2
			add.w	&RESULT,R7

			mov.w	@R4+, 	&MPY_OP2
			add.w	&RESULT,R8
			mov.w	@R4+, 	&MPY_OP2
			add.w	&RESULT,R9
			mov.w	@R4+, 	&MPY_OP2
			add.w	&RESULT,R10
			mov.w	@R4+, 	&MPY_OP2
			add.w	&RESULT,R11
			mov.w	@R4+, 	&MPY_OP2
			add.w	&RESULT,R12
			mov.w	@R4+, 	&MPY_OP2
			add.w	&RESULT,R13
			mov.w	@R4+, 	&MPY_OP2
			add.w	&RESULT,R14
			mov.w	@R4+, 	&MPY_OP2
			add.w	&RESULT,R15

			; shift a-ptr to start of next col
			add.w 	#(M2-9*2), R4	; 9*1 tile
			; shift b-ptr to next row
			add.w	#N2, R5

			sub.w	#1, R6
			jnz kernel_indirect_loop_k; <--- 3

			; reset a and b
			sub.w	#(M2*K), R4
			sub.w	#(N2*K), R5

			jmp kernel_return

;-------------------------------------------------------------------------------
; Kernel 2: Using DMA
;-------------------------------------------------------------------------------

kernel_dma:
			mov.w	R4, R6
			add.w	#2, R6
			mov.w	R6, &DMA1SAL		; load a-ptr with offset

			mov.w	#K, R6
kernel_dma_loop_k:
			mov.w	@R5, &MPY_OP1	; <-- 3b
			bis.w	#DMAEN, &DMA1CTL	; enable DMA
			mov.w	@R4, &MPY_OP2		; trigger DMA

			add.w	&RESULT, R7		; 5 cycles
			add.w	&RESULT, R8		; 5 cycles
			add.w	&RESULT, R9
			add.w	&RESULT, R10
			add.w	&RESULT, R11
			add.w	&RESULT, R12
			add.w	&RESULT, R13
			add.w	&RESULT, R14
			add.w	&RESULT, R15
			bic.w	#DMAEN,	&DMA1CTL 	; disable DMA

			add.w	#M2, R4
			add.w	#M2, &DMA1SAL
			add.w	#N2, R5

			sub.w	#1, R6
			jnz kernel_dma_loop_k ;<-- 3b

			; reset a and b
			sub.w	#(M2*K), R4
			sub.w	#(N2*K), R5

			jmp kernel_return
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
            
