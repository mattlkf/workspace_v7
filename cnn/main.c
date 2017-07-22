#include <msp430.h>
#include <stdint.h>
//#include <stdio.h>

#pragma PERSISTENT(weights)
 int16_t weights[600] = {147,-122,84,110,247,46,100,235,159,31,18,32,-154,122,-149,-37,-123,-132,43,125,6147,-4759,-3800,14431,-3232,17658,22037,24688,11936,-8272,-13074,2382,-1452,-10870,1630,-5408,-988,-8134,-3585,-5017,-7816,5550,-5322,3054,-10886,-5932,9189,-4488,-3111,14289,5314,4944,11476,-293,-612,10299,50,82,-16250,-14958,-13812,-6126,-1769,-1923,5787,-2442,-7618,-1221,4777,10066,810,7717,16169,3613,699,3111,12480,995,-4608,-10971,1918,4485,-5456,-5714,366,-4119,3511,7485,5392,-7540,2686,-3840,-6973,-2683,2123,1070,2982,8110,-398,-3622,776,6206,-7866,-27,-7625,-3222,-12,-2820,10808,-1106,5650,4149,86,-1201,5931,13095,10803,8979,8463,10027,-5153,3023,11695,-15774,-12484,-10307,6475,18604,-9997,2866,957,7258,-6227,-1529,-1288,-6112,-7957,4367,-6826,5387,-6466,877,-195,-17,-356,-2056,-9991,4977,-2314,6637,-1061,-4772,-4496,4271,-6413,-1443,1454,2373,-9,33,-5137,13082,377,8410,-3767,-504,6648,2459,1779,-2837,-3928,-12065,15025,4248,12663,-11941,-6164,5325,-2486,-293,4654,20380,-13929,-2623,3543,14398,3768,2652,-12591,4051,-4340,-13309,-5681,884,-8468,-11726,-7068,-7455,5046,8472,457,-4115,-4547,-9263,2324,7620,-7398,5113,-4057,-8792,-9022,5897,-8570,-1473,12109,6746,5551,-6994,1340,-3044,-2102,2810,-6421,-1203,18857,5337,5360,5122,10735,-9574,-2278,14855,-8067,-1863,350,-3112,-70,11262,1613,-6575,12077,-22590,-11046,7673,2357,-6785,5221,-3063,11713,2134,7619,-6259,8509,3357,-3585,-8074,13968,-7008,-1333,2480,-9882,-894,-7710,-18579,-5270,-10820,-5020,6953,-7409,-1315,-984,-5276,3662,-8613,12419,3071,6201,-7266,7007,4083,10742,1365,16958,-2450,11117,-3612,-7114,-10948,5935,10158,3828,-11714,1179,9635,6106,-10832,-929,-2103,1649,8529,-4771,3603,-7158,196,-8307,-7676,-7252,-1567,-892,-13443,3394,11436,-1666,-199,288,6875,-6247,-9806,4378,-11057,3727,9999,-14722,-424,-1261,6888,-5008,-106,4856,-18393,-10952,6368,15282,16332,-2088,5500,7813,2927,-6840,14623,10614,2289,-18118,10059,5040,-10750,1229,-6137,16885,7297,10950,-4258,15133,3485,-289,-1978,-542,-2384,3392,-5771,3541,6500,-3411,-1447,6081,-9095,-9366,10618,9066,2172,16835,11600,8229,1224,3214,-11780,6489,-5674,-10025,10278,-1306,6411,400,-1241,436,-2484,8229,-1010,2223,588,2370,7933,-1154,3361,-1146,7629,13710,2936,4356,-3350,3972,12096,8377,-2079,-6874,-12938,-705,-3812,-4757,1703,20328,2173,-14530,704,-6004,5290,7394,-12804,-9993,-9217,-2648,1613,6950,-484,4977,-7877,-1829,-10414,1035,-583,-11528,-7967,5748,-8191,574,-3147,1115,-5549,-427,-10118,16901,17734,5387,8515,3971,4163,2924,2533,-2277,-7835,3219,-4044,-4925,-8701,-4629,11314,11576,5209,-10400,-11733,5524,2378,-502,12249,5018,-7933,-1042,-12343,-4880,-9577,3684,-5214,3508,6920,-7600,-8265,-10990,-11938,6807,1332,-3,-1,60,45,-27,-6,-6,-74,32,-3,-9788,-7637,-1093,21230,4703,12003,-15282,-10312,-3738,17904,31449,-7592,-24147,-15157,-7593,707,-10241,-17856,5972,536,-2423,-5858,-10242,-7146,-6205,3226,1621,4107,8394,888,11758,7361,-9295,3332,8636,8593,-14631,16140,635,-1539,5526,17819,7922,9948,-17981,-18488,-15512,-13115,23185,11317,8779,-5124,15964,-6980,-13884,7655,-14079,11272,-830,5365,-5376,-5023,9532,-10705,-3274,11853,-23235,-11711,21472,16375,14290,-12397,19243,-2354,-13275,-25767,5757,1049,-11210,14976,13158,-129,-13589,17201,-8669,4561,-10129,-11894,6167,12804,11102,-11058,316,20223,-11584,-18415,-6678,-2512,6060,-6070,37,88,80,-60,30,-34,-9,0,-63,-68};
int16_t *w_ptr = weights;

#pragma PERSISTENT(img)
 int16_t img[784] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8224,8224,24543,32735,32735,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32735,32735,32735,32735,32735,24543,0,0,0,0,0,24543,24543,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24543,32735,32735,32735,32735,32735,32735,0,0,0,16448,32735,32735,32735,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32735,32735,32735,32735,24543,32735,32735,0,0,16448,32735,32735,32735,24543,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32735,32735,32735,0,8224,32735,32735,0,16448,32735,32735,32735,32735,16448,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24543,32735,32735,24543,0,24543,32735,32735,32735,32735,32735,16448,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32735,32735,32735,8224,24543,32735,32735,32735,32735,24543,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16448,32735,32735,32735,32735,32735,32735,24543,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16448,32735,32735,32735,32735,32735,16448,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8224,32735,32735,32735,32735,24543,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8224,16448,32735,32735,32735,32735,24543,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16448,32735,32735,32735,32735,32735,32735,16448,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16448,32735,32735,32735,32735,32735,32735,32735,8224,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32735,32735,32735,32735,8224,32735,32735,32735,24543,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16448,32735,32735,32735,8224,8224,32735,32735,32735,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24543,32735,32735,24543,8224,32735,32735,32735,32735,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16448,32735,32735,16448,24543,32735,32735,32735,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8224,32735,32735,32735,32735,32735,32735,8224,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16448,32735,32735,32735,32735,16448,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8224,32735,32735,32735,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};

typedef struct{
  int x, y, z;
  int16_t *val;
  int16_t bias;
} kernel_t;

typedef struct{
  int x, y, z;
  int16_t *val;
} layer_t;

typedef struct{
  int n_in; // the number of input nodes
  int n_out; // the number of output nodes
  int16_t *val;
  int16_t *bias;
} dense_weights_t;


extern void convolve_asm(layer_t *in, kernel_t *kernels, layer_t *out);


#define MAX_BUF_SIZE 1352
#pragma PERSISTENT(buf)
int16_t buf[2][MAX_BUF_SIZE] = {0};

layer_t define_layer(int x, int y, int z){
  static int tog = 1;
  tog = 1 - tog;

  layer_t ret;
  ret.x = x;
  ret.y = y;
  ret.z = z;
  ret.val = buf[tog];
  return ret;
}

int16_t mul(int16_t x, int16_t y){
  int32_t res = (int32_t) x * (int32_t) y;
  return (int16_t)(res >> 15);
}

void read_kernels(kernel_t *k, int nk, int x, int y, int z){
  int i;
  // Read kernel weights
  for(i=0;i<nk;i++){
    k[i].val = w_ptr;
    w_ptr += x*y*z;

    k[i].x = x;
    k[i].y = y;
    k[i].z = z;
  }

  // Read biases
  for(i=0;i<nk;i++){
    k[i].bias = *(w_ptr++);
  }
}

void read_dense(dense_weights_t *d, int x, int y){
  d->val = w_ptr;
  w_ptr += x * y;
  d->bias = w_ptr;
  w_ptr += y;
  d->n_in = x;
  d->n_out = y;
}

// Data structures

layer_t layer_0;
// Layer 1 (Conv)
kernel_t conv_1[2]; // two 3x3 kernels
layer_t layer_1;
// Layer 2 (Conv)
kernel_t conv_2[2]; // two 3x3 kernels
layer_t layer_2;
// Layer 3 (Pool)
layer_t layer_3; // after 2x2 pooling
// Layer 4 (Conv)
kernel_t conv_3[2]; // two 5x5 kernels
layer_t layer_4;
// Layer 5 (Pool)
layer_t layer_5; // after 2x2 pooling
// Layer 6 (Dense)
dense_weights_t dense_1;
layer_t layer_6;
// Layer 7 (Dense)
dense_weights_t dense_2;
layer_t layer_7;

void convolve(layer_t *in, kernel_t *kernels, layer_t *out){
  // Generate each output layer by convolving the correct kernel..

  // Stack variables
  int16_t s[30];
  s[0] = out->z; // doubles as ok
   s[1] = kernels;
   s[2] = in->val;
  s[3] = out->x;
  s[4] = 0; // used as oi
  s[5] = out->y - 1;
  s[6] = 0; // used as oj
  s[7] = out->y & (~7);
  s[8] = out->y & 7;
  s[9] = 0; // k
  s[10] = (out->x - 1) * in->y;
  s[11] = in->x * in->y;
  s[12] = 8 - in->z * s[11];
  s[13] = 1 - in->z * s[11];
  s[14] = in->y - out->y;
  s[15] = ((kernel_t *) kernels) -> z;
  s[16] = ((kernel_t *) kernels) -> x;
  s[17] = ((kernel_t *) kernels) -> y;
  s[18] = 0; // reserved for kernel->bias
  s[19] = 0; // reserved for kernel->val
   s[20] = in->val;
   s[21] = out->val; // reserved for out_ptr

  // Registers:
  // 8 accumulators
  // i
  // j
  // k_ptr
  // in_ptr

  int16_t reg[8];
  int16_t *out_ptr = out->val;

  int i, j, ri;

  for(;s[0]>0;s[0]--){

    // this should be from s[1]
    kernel_t *kernel = kernels++;

    s[18] = kernel->bias;
    // s[19] = kernel->val;

    // int16_t *in_ptr = s[20];
    int16_t *in_ptr = in->val;

    // For each element of output..
    for(s[4]=s[3];s[4]>0;s[4]--){
      // The general case, when there are more than 8 cycles left
      for(s[6]=s[7];s[6]>0;s[6] -= 8){
        // Do this efficiently by loading into one reg and copy into the others
        for(ri=0;ri<8;ri++) reg[ri] = s[18]; // the kernel bias

        // Reset k_ptr to start of kernel
        int16_t *k_ptr = kernel->val; // should be s[19]

        // Apply the kernel to 8 consecutive input elements
        for(s[9]=s[15];s[9]>0;s[9]--){ // For each layer
          for(i=s[16];i>0;i--){
            for(j=s[17];j>0;j--){

              int16_t elem_k = *(k_ptr++); // mov into MPY_1

              for(ri=0;ri<8;ri++){
                int16_t elem_in = *(in_ptr++); // mov into MPY_2

                // reg[ri] += elem_in * elem_k; // add result to a reg
                reg[ri] += mul(elem_in, elem_k); // add result to a reg
              }
              in_ptr -= 7;
            }

            in_ptr += s[5];
          }
          in_ptr += s[10];
        }

        // Load out_ptr and restore it..
        // int16_t *out_ptr = s[21];
        for(ri=0;ri<8;ri++){
          *(out_ptr++) = reg[ri];
        }
        // s[21] = out_ptr;

        in_ptr += s[12];
      }


      // The tail case, when there are less than 8 cycles left

      for(s[6] = s[8];s[6]>0;s[6]--){

        reg[0] = kernel->bias;

        // Reset k_ptr to start of kernel
        int16_t *k_ptr = kernel->val;

        // Apply the kernel to 8 consecutive input elements
        for(s[9]=s[15];s[9]>0;s[9]--){ // For each layer
          for(i=s[16];i>0;i--){
            for(j=s[17];j>0;j--){
              int16_t elem_k = *(k_ptr++);
              int16_t elem_in = *(in_ptr++);
              reg[0] += mul(elem_in, elem_k);
            }
            in_ptr += s[5];
          }
          in_ptr += s[10];
        }

        // int16_t *out_ptr = s[21];
        *(out_ptr++) = reg[0];
        // s[21] = out_ptr;

        in_ptr += s[13];
      }
      // End of tail case
      in_ptr += s[14];
    }
  }
}
void relu(layer_t *in){
  int i;
  for(i=0;i<in->z * in->x * in->y;i++){
    if(in->val[i] < 0) in->val[i] = 0;
  }
}

void pool_2x2(layer_t *in, layer_t *out){
  int k, i, j;
  int in_xy =  in->x * in->y;
  int out_xy = out->x * out->y;

  for(k=0;k<out->z;k++){
    for(i=0;i<out->x;i++){
      for(j=0;j<out->y;j++){
        int16_t max = 0;

        if(in->val[k * in_xy + i*2*in->y + j*2] > max){
          max = in->val[k * in_xy + i*2*in->y + j*2];
        }
        if(in->val[k * in_xy + i*2*in->y + j*2 + 1] > max){
          max = in->val[k * in_xy + i*2*in->y + j*2 + 1];
        }
        if(in->val[k * in_xy + (i*2+1)*in->y + j*2] > max){
          max = in->val[k * in_xy + (i*2+1)*in->y + j*2];
        }
        if(in->val[k * in_xy + (i*2+1)*in->y + j*2+1] > max){
          max = in->val[k * in_xy + (i*2+1)*in->y + j*2+1];
        }

        out->val[k * out_xy + i * out->y + j] = max;
      }
    }
  }
}

void dense(layer_t *in, dense_weights_t *d, layer_t *out){
  // Loop over output values
  int i, j;
  for(i=0;i<d->n_out;i++){
    int16_t mac = d->bias[i];
    for(j=0;j<d->n_in;j++){
      // mac += d->val[i * d->n_in + j] * in->val[j];
      mac += mul(d->val[i * d->n_in + j], in->val[j]);
    }
    out->val[i] = mac;
  }
}

int16_t argmax(layer_t *in){
  int ret = 0;
  int i;
  for(i=0;i<in->x * in->y * in->z;i++){
    if(in->val[i] > in->val[ret]) ret = i;
  }
  return ret;
}

void read_layer(layer_t *in){
  in->val = img;
}

int main(void){
   volatile int prediction = 42;
   WDTCTL = WDTPW | WDTHOLD;    // Stop watchdog timer


  // Init layers
  layer_0 = define_layer(28, 28, 1);
  layer_1 = define_layer(26, 26, 2); // after 3x3 conv
  layer_2 = define_layer(24, 24, 2); // after 3x3 conv
  layer_3 = define_layer(12, 12, 2); // after 2x2 pool
  layer_4 = define_layer(8, 8, 2); // after 5x5 conv
  layer_5 = define_layer(4, 4, 2); // after 2x2 pool
  layer_6 = define_layer(10, 1, 1); // after dense 1
  layer_7 = define_layer(10, 1, 1); // after dense 2

  // Init weights
  read_kernels(conv_1, 2, 3, 3, 1); // two 3x3x1 kernels
  read_kernels(conv_2, 2, 3, 3, 2); // two 3x3x2 kernels
  read_kernels(conv_3, 2, 5, 5, 2); // two 5x5x2 kernels
  read_dense(&dense_1, 32, 10);
  read_dense(&dense_2, 10, 10);

  // Read in the input layer
  read_layer(&layer_0);

  // Run it..
  convolve_asm(&layer_0, conv_1, &layer_1);
  relu(&layer_1);
  convolve_asm(&layer_1, conv_2, &layer_2);
  relu(&layer_2);
  pool_2x2(&layer_2, &layer_3);
  convolve_asm(&layer_3, conv_3, &layer_4);
  relu(&layer_4);
  pool_2x2(&layer_4, &layer_5);
  dense(&layer_5, &dense_1, &layer_6);
  relu(&layer_6);
  dense(&layer_6, &dense_2, &layer_7);

  // Take the argmax of the last layer
  prediction = argmax(&layer_7);
// printf("Prediction: %d\n", prediction);

  return 0;
}
