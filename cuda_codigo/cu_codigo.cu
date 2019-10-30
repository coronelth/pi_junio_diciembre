// includes

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cuda_runtime.h>

//-------------Funcion llenar "velocidad"
void llenarVelocidad(double ** pmat, int row, int colum);
//-------------Funcion llenar los vecinos
void llenarVecinos(int ** pmat, int row, int colum);
//-------------Funcion sumar velocidad
__global__ void sumarvelocidad(double ** pdist,int ** pvec,double ** psum, int node); 



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
double *dev_velocidad;
double *dev_suma;
double *hst_velocidad;


// reserva en el host
hst_velocidad = (double*)malloc( node*nvel*sizeof(double) );

// reserva en el device
cudaMalloc( (void**)&dev_velocidad, node*nvel*sizeof(double) );
cudaMalloc( (void**)&dev_suma, node*nvel*sizeof(double) );
cudaMalloc( (void**)&dev_vecinos, node*nvec*sizeof(int) );

// inicializacion de datos

llenarVecinos(&dev_vecinos, row, colum);
llenarVelocidad(&dev_velocidad, row, colum);


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
	sumarvelocidad<<<16,256>>>(&dev_velocidad, &dev_vecinos, &dev_suma, node);



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
cudaMemcpy(hst_velocidad, dev_velocidad, node*nvel*sizeof(float), cudaMemcpyDeviceToHost);
// salida


cudaFree( dev_vecinos );
cudaFree( dev_velocidad );
cudaFree( hst_velocidad );


return 0;
}
