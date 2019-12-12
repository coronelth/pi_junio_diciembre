#include <stdio.h>
#include <stdlib.h>
#include <assert.h>


float ** allocaMatriz(int node, int nveloc) {	
	int i;
	float **pmat;
	pmat = (float **) malloc(node * sizeof(float*));
	if( pmat == NULL )
	return NULL; 

	for( i=0; i<node; i++){
		pmat[i]=(float *) malloc(nveloc * sizeof(float));
			if( pmat[i] == NULL ){
				liberaMatriz(pmat,i);
	return NULL;
	}
	}
	return pmat;
}
