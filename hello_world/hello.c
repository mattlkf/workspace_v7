#include <stdio.h>
#include <msp430.h> 

/*
 * main.c
 */

#define M 3
//#define N 3
#define K 2

#define ZN 3

#pragma PERSISTENT(z)
volatile int z[ZN] = {1,2,3};

volatile int dest[ZN];

//int a[M][K] = {{1,2},{3,4},{5,6}};
//int b[K][N] = {{1,2,3},{4,5,6}};
//int c[M][N];

int main(void) {
    WDTCTL = WDTPW | WDTHOLD; // Stop watchdog timer

    int i;
    for(i=5;i>0;i++){
        z[0] = 8;
    }

//    printf("Hello World\n");

    // Naive 3-loop method
    z[0] = 17;
    z[0] = 16;
    z[0] = 15;
    z[0] = 16;
    z[0] = 15;
    z[0] = 17;
    z[0] = 16;
    z[0] = 15;
    z[0] = 16;
//    z[0] = 15;

//    volatile int j = &z;
//
//    dest[0] = z[0];
//    dest[0] = z[0];
//    dest[0] = z[0];
//    dest[0] = z[0];
//    dest[0] = z[0];
//    dest[0] = z[0];
//    dest[0] = z[0];
//    dest[0] = z[0];
//    dest[0] = z[0];
////    dest[0] = z[0];
//
//    j = &dest;
//
//    register int x;
//    x = z[0];
//    x = z[0];
//    x = z[0];
//    x = z[0];
//    x = z[0];
//    x = z[0];
//    x = z[0];
//    x = z[0];
//    x = z[0];
////    x = z[0];
//
//    j = &dest;
//
//    z[0] = x;
//    z[0] = x;
//    z[0] = x;
//    z[0] = x;
//    z[0] = x;
//
//    z[0] = x;
//    z[0] = x;
//    z[0] = x;
//    z[0] = x;
////    z[0] = x;
//
//    j = &dest;
//
//    z[0] = dest[0];
//    z[0] = dest[0];
//    z[0] = dest[0];
//    z[0] = dest[0];
//    z[0] = dest[0];
//
//    z[0] = dest[0];
//    z[0] = dest[0];
//    z[0] = dest[0];
//    z[0] = dest[0];
////    z[0] = dest[0];
//
//    j = dest;
//
//    x = dest[0];
//    x = dest[0];
//    x = dest[0];
//    x = dest[0];
//    x = dest[0];
//
//    x = dest[0];
//    x = dest[0];
//    x = dest[0];
//    x = dest[0];
////    x = dest[0];
//
//    j = dest;
//
//    dest[0] = x;
//    dest[0] = x;
//    dest[0] = x;
//    dest[0] = x;
//    dest[0] = x;
//
//    dest[0] = x;
//    dest[0] = x;
//    dest[0] = x;
//    dest[0] = x;
////    dest[0] = x;
//
//    j = dest;

    //    for(i=0;i<M;i++){
//        for(j=0;j<N;j++){
//            c[i][j] = 0;
//            for(k=0;k<K;k++){
//                c[i][j] += a[i][k] * b[k][j];
//            }
//        }
//    }

//    // Print for sanity
//    for(i=0;i<M;i++){
//        for(j=0;j<N;j++){
//            printf("%d ", c[i][j]);
//        }
//        printf("\n");
//    }

    return 0;
}



