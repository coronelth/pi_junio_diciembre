// includes

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cuda_runtime.h>


//-------------Funcion sumar velocidad

__global__ void sumarvelocidad(float * pdist,int * pvec,float * psum, int node) {

int nvec=9;	//numero de vecinos
int ndist=9;	//numero de funcion de distribucion
int k=0;
int x = threadIdx.x + blockIdx.x * blockDim.x;
int y = threadIdx.y + blockIdx.y * blockDim.y;

if (x<node){ //para que se paralelice en cada nodo
	if (y<nvec){	//para que se paralelice en cada vecino
		for(k=0;k<ndist;k++){	//para cada velocidad realizo la suma al no saber como paralelizar esta parte
			psum[(x*ndist+k)]+=  pdist[((pvec[(x*nvec+y)])*ndist+k)];
				
						}
		}


		}
}

// nodo == x
//vecino == y
//velocidad == k
