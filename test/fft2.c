
extern int input_dsp();
extern void output_dsp();
extern int abs();
extern float fabs();
extern float fmod();
extern float asin();
extern float acos();
extern float ceil();
extern float cos();
extern float exp();
extern float floor();
extern float log();
extern float log10();
extern float sin();
extern float sqrt();
extern float pow();
extern float tan();
extern float atan();

float data_real[256];
float data_imag[256];
float coef_real[256];
float coef_imag[256];

main()
{
  void fft();
  int i;
  int j=0;

  input_dsp (data_real, 256, 0);

  for (i=0 ; i<256 ; i++){
  *(data_imag + j) = 1;
  *(coef_real + j) = 2;
  *(coef_imag + j) = 2;
  j++;
  }
  fft(data_real, data_imag, coef_real, coef_imag);

  output_dsp (data_real, 256, 0);
  output_dsp (data_imag, 256, 0);
  output_dsp (coef_real, 256, 0);
  output_dsp (coef_imag, 256, 0);

}

void fft(data_real, data_imag, coef_real, coef_imag)
float *data_real;
float *data_imag;
float *coef_real;
float *coef_imag;
{
  int i;
  int j;
  int k;
  float *A_real;
  float *A_imag;
  float *B_real;
  float *B_imag;
  float temp_real;
  float temp_imag;
  float Ar;
  float Ai;
  float Br;
  float Bi;
  float Wr;
  float Wi;
  int groupsPerStage = 1;
  int buttersPerGroup = 256 / 2;
  for (i = 0; i < 8; i++) {
    A_real = data_real;
    A_imag = data_imag;
    B_real = data_real + buttersPerGroup;
    B_imag = data_imag + buttersPerGroup;
    j = 0;
    do {
      Wr = *coef_real++;
      Wi = *coef_imag++;
      k = 0;
      do {
        Ar = *A_real;
        Ai = *A_imag;
        Br = *B_real;
        Bi = *B_imag;
        temp_real = Wr * Br - Wi * Bi;
        temp_imag = Wi * Br + Wr * Bi;
        *A_real++ = Ar + temp_real;
        *B_real++ = Ar - temp_real;
        *A_imag++ = Ai + temp_imag;
        *B_imag++ = Ai - temp_imag;
        k++;
      } while (k < buttersPerGroup);
      A_real += buttersPerGroup;
      A_imag += buttersPerGroup;
      B_real += buttersPerGroup;
      B_imag += buttersPerGroup;
      j++;
    } while (j < groupsPerStage);
    groupsPerStage <<= 1;
    buttersPerGroup >>= 1;
  }
}
