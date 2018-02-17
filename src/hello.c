
#define ARM_MATH_CM0PLUS
#include <stdio.h>
#include <arm_math.h>
#include <arm_const_structs.h>

#define FFTSIZE 64

q15_t fftBuf[FFTSIZE*2];
q15_t magBuf[FFTSIZE];

int main(void) {
	arm_cfft_radix4_instance_q15 S;
	int i;

	arm_cfft_radix4_init_q15(&S, FFTSIZE, 0, 1);
	for (i=0; i<FFTSIZE*2; i++)
		fftBuf[i] = i;



	for (i=0; i<10; i++) {
		printf("Hello ARM!\n");
		arm_cfft_q15(&arm_cfft_sR_q15_len64, fftBuf, 0, 1);

		arm_cfft_radix4_q15(&S, fftBuf);
		arm_cmplx_mag_q15(fftBuf, magBuf, FFTSIZE);
	}
	return 0;
}
