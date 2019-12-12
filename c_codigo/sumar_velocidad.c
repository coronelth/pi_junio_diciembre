#include <stdio.h>
#include <stdlib.h>

// Sumar velocidades

void sumarVelocidad(float ** pdist,int ** pvec,float ** psum, int node){
	int i,j;	
	int nvec=9;
	int nvel=9;

	for(i=0;i<node;i++){	//para cada nodo
		for(j=0;j<nvel;j++){	//para cada velocidad
			psum[i][0]+=pdist[i][j];			
	}	
}
}

