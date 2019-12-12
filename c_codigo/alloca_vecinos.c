#include <stdio.h>
#include <stdlib.h>

#include "libera_vecinos.h"

int ** allocaVecinos(int node, int nvecinos) {	
	int i;
	int **pmat;
	pmat = (int **) malloc(node * sizeof(int*));
	if( pmat == NULL )
	return NULL; 

	for( i=0; i<node; i++){
		pmat[i]=(int *) malloc(nvecinos * sizeof(int));
			if( pmat[i] == NULL ){
				liberaVecinos(pmat,i);
	return NULL;
	}
	}
	return pmat;
}
