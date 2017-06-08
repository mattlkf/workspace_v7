#include <stdint.h>
#include <stdio.h>
#include <msp430.h> 

// How many fractional bits to use in the fixed-point format
#define N_FRAC_BITS 8

// How to perform multiplication on two fixed-point numbers?
#define MUL(a,b) (int32_t)(((int64_t)(a) * (int64_t)(b)) >> N_FRAC_BITS)

// Size of the matrices that we are playing with
#define M 3
#define N 3
#define K 2

int32_t a[M][K] = {{256,512},{768,1024},{1280,1536}};
int32_t b[K][N] = {{256,512,768},{1024,1280,1536}};

//int32_t a[M][K] = {{1,2},{3,4},{5,6}};
//int32_t b[K][N] = {{1,2,3},{4,5,6}};
int32_t c[M*N];

// Desired output if using 0 fractional bits:
// 9 12 15
// 19 26 33
// 29 40 51

// Desired output if using 8 fractional bits
// 2304 3072 3840
// 4864 6656 8448
// 7424 10240 13056

void naive_a();
void naive_b();
void naive_c();
void print_result();

int main(void) {
    WDTCTL = WDTPW | WDTHOLD;	// Stop watchdog timer

//    naive_a();
//    naive_b();
    naive_c();

    print_result();

	return 0;
}

void print_result(){
    // Print for sanity
    int i, j;
    for(i=0;i<M;i++){
        for(j=0;j<N;j++){
            printf("%d ", c[i*N+j]);
        }
        printf("\n");
    }
}
/*
// 2501 cycles (16 bits, int)
// 2950 cycles (32 bits, int)
// 4546 cycles (32 bits, fixed-point 24:8 float)
void naive_a(){
    int i, j, k;
    for(i=0;i<M;i++){
        for(j=0;j<N;j++){
            c[i][j] = 0;
            for(k=0;k<K;k++){
                c[i][j] += MUL(a[i][k], b[k][j]);
            }
        }
    }
}

// 1866 cycles (16 bits)
// 2261 cycles (32 bits)
// 3903 cycles (32 bits, fixed-point 24:8 float)
void naive_b(){
    // Naive 3-loop method with variable accumulator
    int i, j, k;
    for(i=0;i<M;i++){
        for(j=0;j<N;j++){
            int32_t temp = 0;
            for(k=0;k<K;k++){
                temp += MUL(a[i][k], b[k][j]);
            }
            c[i][j] = temp;
        }
    }
}
*/
// 3014 cycles (32 bits, int)
// 4610 cycles (32 bits, fixed-point 24:8 float)
void naive_c(){
    int  k;


      register int32_t c0, c1, c3, c4;

      c0 = c1 = c3 = c4 = 0;

    for(k=0;k<K;k++){
//        for(i=0;i<M;i++){
            //for(j=0;j<N;j++){
        int32_t val_a = a[0][k];
        int32_t val_b0 = b[k][0];
        int32_t val_b1 = b[k][1];
        //int32_t val_b2 = b[k][2];





                c0 += val_a * val_b0;
                c1 += val_a * val_b1;
          //      c2 += val_a * val_b2;

                val_a = a[1][k];

                c3 += val_a * val_b0;
                c4 += val_a * val_b1;
            //    c5 += val_a * val_b2;


//                c[3] = val_a * b[k][0];
//                c[4] = val_a * b[k][1];
//                c[5] = val_a * b[k][2];
/*
                val_a = a[2][k];
                c6 += val_a * val_b0;
                c7 += val_a * val_b1;
                */
              //  c8 += val_a * val_b2;

//                c[6] = val_a * b[k][0];
//                c[7] = val_a * b[k][1];
//                c[8] = val_a * b[k][2];

//            }
//        }
    }

    c[0] =  c0;
    c[1] = c1;
    c[2] = c3;
    c[3] = c4;
}
