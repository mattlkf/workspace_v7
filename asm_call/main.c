#include <msp430.h>
#include <stdint.h>

extern uint16_t strLen(const char* s1);
extern int16_t plus_asm(int16_t a, int16_t b, int16_t c);

/*
 * main.c
 */
int main(void) {
    WDTCTL = WDTPW | WDTHOLD;	// Stop watchdog timer

    int16_t a = 5;
    int16_t b = 1;
    int16_t c = 3;

    int16_t d = plus_asm(a,b,c);
    int16_t e = plus_asm(a,b,c);


    return 0;
}
