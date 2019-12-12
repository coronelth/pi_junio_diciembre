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
#include "densidad_suma_if_for.h"
#include "densidad_suma_doble_if.h"

// MAIN: rutina principal ejecutada en el host
int main(int argc, char** argv)
{

// declaracion
int row   = 6;
int colum = 6;
int node  = row*colum;
int nvec  = 9;
int nvel  = 9;
int one   = 1;
int i;

int *dev_vecinos;
float *dev_velocidad;
float *dev_suma;

// reserva en el host

int* hst_vecinos   = allocaVecinos(node,nvec);
float* hst_velocidad = allocaVector(node,nvel);
float* hst_suma      = allocaVector(node,one);

// reserva en el device
cudaMalloc( (void**)&dev_vecinos, node*nvec*sizeof(int));
cudaMalloc( (void**)&dev_velocidad, node*nvel*sizeof(float));
cudaMalloc( (void**)&dev_suma, node*sizeof(float));


// inicializacion de datos
llenarVecinos(hst_vecinos, row, colum);
llenarVelocidad(hst_velocidad, row, colum);

for(i=0;i<node;i++){ // inicializar en cero el valor de la hst_suma
	hst_suma[i] = 0;
}


// pasaje de los datos del hst al dev 

cudaMemcpy(dev_vecinos,hst_vecinos,node*nvel*sizeof(int),cudaMemcpyHostToDevice);
cudaMemcpy(dev_velocidad,hst_velocidad,node*nvel*sizeof(float),cudaMemcpyHostToDevice);
cudaMemcpy(dev_suma,hst_suma,node*one*sizeof(float),cudaMemcpyHostToDevice);

/*
// ------------------- ver que se este realizando bien el pasaje de los datos

liberaVecinos(hst_vecinos);
liberaVector(hst_suma);
liberaVector(hst_velocidad);

int*   hst_vecinos_p   = allocaVecinos(node,nvec);
float* hst_velocidad_p = allocaVector(node,nvel);
float* hst_suma_p      = allocaVector(node,nvel);

cudaMemcpy(hst_vecinos_p, dev_vecinos, node*nvel*sizeof(int), cudaMemcpyDeviceToHost);
cudaMemcpy(hst_velocidad_p, dev_velocidad, node*nvel*sizeof(int), cudaMemcpyDeviceToHost);
cudaMemcpy(hst_suma_p, dev_suma, node*nvel*sizeof(int), cudaMemcpyDeviceToHost);

// ver que es lo que tienen las matrices que se acaban de llenar en la alocacion

int j=0;
for(i=0;i<node;i++){
		for(j=0;j<nvec;j++){
			printf("%d\t",hst_vecinos_p[i*nvel+j]); 
		}
		printf("\n");
}
printf("\n\n");


for(i=0;i<node;i++){
		for(j=0;j<nvec;j++){
			printf("%f\t",hst_velocidad_p[i*nvel+j]); 
		}
		printf("\n");
}
printf("\n\n");

for(i=0;i<node;i++){
		for(j=0;j<nvec;j++){
			printf("%f\t",hst_suma_p[i*nvel+j]); 
		}
		printf("\n");
}
printf("\n\n");
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

	densidad_suma_if_for<<<64,256>>>(dev_velocidad,dev_suma,node); 
   if (cudaDeviceSynchronize() != cudaSuccess) {
       fprintf (stderr, "Cuda call failed\n");
   }

// aqui va el kernel que realiza la suma que es lo que se quiere medir
// -----------------------------------------------

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
cudaMemcpy(hst_suma, dev_suma, node*one*sizeof(float), cudaMemcpyDeviceToHost);
// salida

// ver si esta sumando bien
   printf( "Contenido de SUMA :\n" );


for(i=0;i<node;i++){
		printf("%f\t",hst_suma[i]); 
		printf("\n");		
		
}
printf("\n\n");
//----------------------------------------------------------Realizo lo mismo para el otro kernel propuesto-----------------------------------------------------------------------

// declaracion de eventos
cudaEvent_t start_p;
cudaEvent_t stop_p;
// creacion de eventos
cudaEventCreate(&start_p);
cudaEventCreate(&stop_p);
// marca de inicio
cudaEventRecord(start_p,0);
// codigo a temporizar en el device

// -----------------------------------------------

	densidad_suma_doble_if<<<64,256>>>(dev_velocidad,dev_suma,node); 
   if (cudaDeviceSynchronize() != cudaSuccess) {
       fprintf (stderr, "Cuda call failed\n");
   }

// aqui va el kernel que realiza la suma que es lo que se quiere medir
// -----------------------------------------------

// marca de final
cudaEventRecord(stop_p,0);
// sincronizacion GPU-CPU
cudaEventSynchronize(stop_p);
// calculo del tiempo en milisegundos
float elapsedTime_p;
cudaEventElapsedTime(&elapsedTime_p,start_p,stop_p);
// impresion de resultados
printf("> Tiempo de ejecucion: %f ms\n",elapsedTime_p);
// liberacion de recursos
cudaEventDestroy(start_p);
cudaEventDestroy(stop_p);

// copia de datos
cudaMemcpy(hst_suma, dev_suma, node*one*sizeof(float), cudaMemcpyDeviceToHost);
// salida

// ver si esta sumando bien
   printf( "Contenido de SUMA :\n" );


for(i=0;i<node;i++){
		printf("%f\t",hst_suma[i]); 
		printf("\n");		
		
}
printf("\n\n");



//----------------------------------------------------------------------------------------------------------------------------------------------------------------------
guardar_suma(hst_suma,node,one);


cudaFree( dev_vecinos );
cudaFree( dev_velocidad );
cudaFree( hst_velocidad );


liberaVector(hst_suma);
liberaVector(hst_velocidad);
liberaVecinos(hst_vecinos);





return 0;
}
