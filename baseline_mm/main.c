#include <stdio.h>
#include <msp430.h> 

/*
 * main.c
 */

#define M 3
#define N 3
#define K 4

//float a[M][K];
//float b[K][N];
//float c[M][N];

int a[5] = {0,1,2,3,4};
int b[5] = {5,6,7,8,9};
int c[25];

int main(void) {
    WDTCTL = WDTPW | WDTHOLD; // Stop watchdog timer

    volatile int x = a[2];
    c[4] = x;

    int i;
    for(i=0;i<5;i++){
        c[i] = a[i+1];
    }

//    printf("Hello World\n");
//
//    // Naive 3-loop method
//    int i, j, k;
//    for(i=0;i<M;i++){
//        for(j=0;j<N;j++){
//            c[i][j] = 0;
//            for(k=0;k<K;k++){
//                c[i][j] += a[i][k] * b[k][j];
//            }
//        }
//    }
//
//    // Print for sanity
//    for(i=0;i<M;i++){
//        for(j=0;j<N;j++){
//            printf("%d ", c[i][j]);
//        }
//        printf("\n");
//    }

  return 0;
}
