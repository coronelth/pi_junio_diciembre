// includes

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cuda_runtime.h>


//-------------Funcion sumar velocidad

__global__ void densidad_suma_if_for(float * pdist,float * psum, int node) {

int ndist=9;	//numero de funcion de distribucion
int x = threadIdx.x + blockIdx.x * blockDim.x;
int y = threadIdx.y + blockIdx.y * blockDim.y;
int i;

if (x<node){ //para que se paralelice en cada nodo
		for(i=0;i<ndist;i++)	
			psum[x]+=  pdist[(x*ndist+i)];
		}
}

// nodo == x
//velocidad == y
