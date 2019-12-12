#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

float *allocaVector(float n) {
	float *v = (float *) malloc(n * sizeof(float));
	assert(v != NULL);
	return v;
}
