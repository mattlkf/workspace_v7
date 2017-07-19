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

Q15_OP1		.equ	0x04C2  ; first operand for signed multiply 16-bit
Q15_OP2		.equ	0x04C8	; second operand
Q15_RESULT	.equ 	0x04CC

MPY32CTL0	.equ 	0x04EC
;-------------------------------------------------------------------------------

RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

; Turn on the fractional mode for the MPY32
			bis.w	#4, &MPY32CTL0			; bit 2 is MPYFRAC

			mov.w	#0x1999, R4
			mov.w	#0xe666, R5
			mov.w	R4, &Q15_OP1		; 0.2
			mov.w	R5, &Q15_OP2		; -0.2
			mov.w	&Q15_RESULT, R6			; expected: fae1 (-0.04)

			nop

			mov.w	#0x1999, R4				; 0.2 in q15 format
			mov.w	#0x2666, R5				; 0.3 in q15 format
			mov.w	R4, &Q15_OP1
			mov.w	R5, &Q15_OP2
			mov.w	&Q15_RESULT, R6			; expected: 7ae (0.6 in q15 format)

			nop

			mov.w	#0xd99a, R4			; -0.3
			mov.w	#0xa667, R5			; -0.7
			mov.w	R4, &Q15_OP1
			mov.w	R5, &Q15_OP2
			mov.w	&Q15_RESULT, R6		; expected: 1ae1 (0.21)

			nop

			mov.w	#0x121f, R4			; 0.14159
			mov.w	#0x5df3, R5			; 0.734
			mov.w	R4, &Q15_OP1
			mov.w	R5, &Q15_OP2
			mov.w	&Q15_RESULT, R6		; expected: d4d (0.103927)

			nop

			mov.w	#0x9b03, R4			; -0.789
			mov.w	#0x7f1a, R5			; 0.993
			mov.w	R4, &Q15_OP1
			mov.w	R5, &Q15_OP2
			mov.w	&Q15_RESULT, R6		; expected: 9bb8 (0.783477)

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
            
