// includes

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cuda_runtime.h>


//-------------Funcion sumar velocidad

__global__ void densidad_suma_doble_if(float * pdist,float * psum, int node) {

int ndist=9;	//numero de funcion de distribucion
int x = threadIdx.x + blockIdx.x * blockDim.x;
int y = threadIdx.y + blockIdx.y * blockDim.y;
int i;

if (x<node){ //para que se paralelice en cada nodo
	if (y<ndist){	//para que se paralelice en cada parte del vector de funcion de distribucion
		psum[x]+=  pdist[(x*ndist+y)];} 
			
			
		}
}

// nodo == x
//velocidad == y
