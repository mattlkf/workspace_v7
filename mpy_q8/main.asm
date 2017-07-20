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
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------

Q8_OP1		.equ	0x04C2  ; first operand for signed multiply 16-bit
Q8_OP2		.equ	0x04C8	; second operand
Q8_RES_1	.equ 	0x04CA	; lower 16 bits of result
Q8_RES_2	.equ	0x04CC	; upper 16 bits of result
Q8_RES_MID	.equ	0x04CB	; try to read a word straddling middle directly

RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer

;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
			mov.w	#0xfff, &Q8_OP1
			mov.w	#0xfff, &Q8_OP2
			mov.w	&Q8_RES_1, R4
			mov.w	&Q8_RES_2, R5
			mov.w	&Q8_RES_MID, R6



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
            
