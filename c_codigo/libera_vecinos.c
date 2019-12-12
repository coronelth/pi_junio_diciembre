#include <stdio.h>
#include <stdlib.h>

void liberaVecinos(int ** pmat, int node) {
	int i;
	for( i=0; i<node; i++)
		free(pmat[i]);
		free(pmat);
	return;
	}
