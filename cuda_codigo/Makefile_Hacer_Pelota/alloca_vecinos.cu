// includes

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

int * allocaVecinos(int node, int nvecinos){
	int *v = (int *) malloc(node * nvecinos * sizeof(int));
	assert(v != NULL);
	return v;
}
