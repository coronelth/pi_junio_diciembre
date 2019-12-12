// includes

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cuda_runtime.h>

#include "llenar_vecinos.h"
#include "alloca_vecinos.h"
#include "libera_vecinos.h"
#include "alloca_vector.h"
#include "libera_vector.h"
#include "llenar_velocidad.h"
#include "sumar_velocidad.h"
#include "guardar_suma.h"

// MAIN: rutina principal ejecutada en el host
int main(int argc, char** argv)
{

// declaracion
int row=6;
int colum=6;
int node=row*colum;
int nvec=9;
int nvel=9;

int *dev_vecinos;
float *dev_velocidad;
float *dev_suma;


/*
// reserva en el host

int** hst_vecinos   = allocaVecinos(node,nvec);
float** hst_velocidad = allocaMatriz(node,nvel);
float** hst_suma      = allocaMatriz(node,nvel);
*/




// reserva en el host

int*   hst_vecinos   = allocaVecinos(node,nvec);
float* hst_velocidad = allocaVector(node,nvel);
float* hst_suma      = allocaVector(node,nvel);

// inicializar en cero el valor de la hst_suma
int i;
for(i=0;i<node;i++)
	hst_suma[i*nvel+nvel] = 0;


// reserva en el device
cudaMalloc( (void**)&dev_vecinos, node*nvec*sizeof(int));
cudaMalloc( (void**)&dev_velocidad, node*nvel*sizeof(float));
cudaMalloc( (void**)&dev_suma, node*nvel*sizeof(float));


// inicializacion de datos
llenarVecinos(hst_vecinos, row, colum);
llenarVelocidad(hst_velocidad, row, colum);

// pasaje de los datos del hst al dev 

cudaMemcpy(dev_vecinos,hst_vecinos,node*nvel*sizeof(int),cudaMemcpyHostToDevice);
cudaMemcpy(dev_velocidad,hst_velocidad,node*nvel*sizeof(float),cudaMemcpyHostToDevice);


printf("Termine de pasar los datos al dev \n\n\n\n");


/*
// ver que es lo que tienen las matrices que se acaban de llenar en la alocacion
int i=0;
int j=0;
for(i=0;i<node;i++){
		for(j=0;j<nvec;j++){
			printf("%d\t",&hst_vecinos[i][j]); 
		}
		printf("\n");
}


printf("Que hay en el dev \n\n\n\n");

*/







// declaracion de eventos
cudaEvent_t start;
cudaEvent_t stop;
// creacion de eventos
cudaEventCreate(&start);
cudaEventCreate(&stop);
// marca de inicio
cudaEventRecord(start,0);
// codigo a temporizar en el device

// -----------------------------------------------

	printf("Llamo al Kernel \n");

//	sumarvelocidad<<<16,256>>>(&dev_velocidad, &dev_vecinos, &dev_suma, node);
	sumarvelocidad<<<16,256>>>(dev_velocidad, dev_vecinos, dev_suma, node);
   if (cudaDeviceSynchronize() != cudaSuccess) {
       fprintf (stderr, "Cuda call failed\n");
   }

// aqui va el kernel que realiza la suma que es lo que se quiere medir
// -----------------------------------------------


// ver si esta sumando bien
/*   printf( "Contenido de SUMA :\n" );

int i=0;
int j=0;

   for (i = 0; i < node; i++) {
      for (j = 0; j < nvec; j++)
	 printf ("%d ", hst_suma[i][j]);
      printf ("\n");
   }*/

// marca de final
cudaEventRecord(stop,0);
// sincronizacion GPU-CPU
cudaEventSynchronize(stop);
// calculo del tiempo en milisegundos
float elapsedTime;
cudaEventElapsedTime(&elapsedTime,start,stop);
// impresion de resultados
printf("> Tiempo de ejecucion: %f ms\n",elapsedTime);
// liberacion de recursos
cudaEventDestroy(start);
cudaEventDestroy(stop);

// copia de datos
cudaMemcpy(hst_velocidad, dev_velocidad, node*nvel*sizeof(float), cudaMemcpyDeviceToHost);
// salida

guardar_suma(hst_velocidad,node,nvel);


cudaFree( dev_vecinos );
cudaFree( dev_velocidad );
cudaFree( hst_velocidad );

/*
liberaMatriz(hst_suma,node);
liberaMatriz(hst_velocidad,node);
liberaVecinos(hst_vecinos,node);
*/



liberaVector(hst_suma);
liberaVector(hst_velocidad);
liberaVecinos(hst_vecinos);














return 0;
}
