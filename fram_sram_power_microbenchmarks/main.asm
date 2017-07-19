;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.

    .global a
    .sect   ".data:a", RW
    .clink
    .align  2
    .elfsym a,SYM_SIZE(10)
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

			mov.w	#0xA5F0, R8 ; 1010 0101 1111 0000

			jmp		read_loop_2
;-------------------------------------------------------------------------------
; #1: Reading from a single location
;-------------------------------------------------------------------------------

read_loop_1:
			mov.w	&a, R8
			mov.w	&a, R8
			mov.w	&a, R8
			mov.w	&a, R8
			mov.w	&a, R8

			mov.w	&a, R8
			mov.w	&a, R8
			mov.w	&a, R8
			mov.w	&a, R8
			mov.w	&a, R8

			mov.w	&a, R8
			mov.w	&a, R8
			mov.w	&a, R8
			mov.w	&a, R8
			mov.w	&a, R8

			mov.w	&a, R8
			mov.w	&a, R8
			mov.w	&a, R8
			mov.w	&a, R8
			mov.w	&a, R8

			jmp 	read_loop_1

;-------------------------------------------------------------------------------
; #2: Writing to a single location
;-------------------------------------------------------------------------------

write_loop_1:
            mov.w R8, &a
            mov.w R8, &a
            mov.w R8, &a
            mov.w R8, &a
            mov.w R8, &a

            mov.w R8, &a
            mov.w R8, &a
            mov.w R8, &a
            mov.w R8, &a
            mov.w R8, &a

            mov.w R8, &a
            mov.w R8, &a
            mov.w R8, &a
            mov.w R8, &a
            mov.w R8, &a

            mov.w R8, &a
            mov.w R8, &a
            mov.w R8, &a
            mov.w R8, &a
            mov.w R8, &a

			jmp		write_loop_1

;-------------------------------------------------------------------------------
; #3: Reading from a series of locations, stride of 1
;-------------------------------------------------------------------------------

read_loop_2:
			mov.w	&a+0, R8
			mov.w	&a+2, R8
			mov.w	&a+4, R8
			mov.w	&a+6, R8
			mov.w	&a+10, R8

			mov.w	&a+12, R8
			mov.w	&a+14, R8
			mov.w	&a+16, R8
			mov.w	&a+18, R8
			mov.w	&a+20, R8

			mov.w	&a+22, R8
			mov.w	&a+24, R8
			mov.w	&a+26, R8
			mov.w	&a+28, R8
			mov.w	&a+30, R8

			mov.w	&a+32, R8
			mov.w	&a+34, R8
			mov.w	&a+36, R8
			mov.w	&a+38, R8
			mov.w	&a+40, R8

			jmp 	read_loop_2

;-------------------------------------------------------------------------------
; #4: Writing to a series of locations, stride of 1
;-------------------------------------------------------------------------------

write_loop_2:
            mov.w R8, &a+0
            mov.w R8, &a+2
            mov.w R8, &a+4
            mov.w R8, &a+6
            mov.w R8, &a+10

            mov.w R8, &a+12
            mov.w R8, &a+14
            mov.w R8, &a+16
            mov.w R8, &a+18
            mov.w R8, &a+20

            mov.w R8, &a+22
            mov.w R8, &a+24
            mov.w R8, &a+26
            mov.w R8, &a+28
            mov.w R8, &a+30

            mov.w R8, &a+32
            mov.w R8, &a+34
            mov.w R8, &a+36
            mov.w R8, &a+38
            mov.w R8, &a+40

			jmp 	write_loop_2

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
            
