
#define ARM_MATH_CM0PLUS
#include <stdio.h>
#include <arm_math.h>
#include <arm_const_structs.h>

#define FFTSIZE 64

q15_t fftBuf[FFTSIZE*2];
q15_t magBuf[FFTSIZE];

int main(void) {
	for (int i; i<10; i++) {
		printf("Hello ARM!\n");
		arm_cfft_q15(&arm_cfft_sR_q15_len64, fftBuf, 0, 0);
		arm_cmplx_mag_q15(fftBuf, magBuf, FFTSIZE);
	}
	return 0;
}
