// includes

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

// Funciones de alocacion  para el vector que representa la Matriz

float *allocaVector(int node, int n) {
	float *v = (float *) malloc(node * n * sizeof(float));
	assert(v != NULL);
	return v;
}
