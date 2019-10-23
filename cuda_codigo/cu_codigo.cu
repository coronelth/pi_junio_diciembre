// includes

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cuda_runtime.h>

//-------------Funcion llenar "velocidad"

void llenarVelocidad(double ** pmat, int row, int colum){
	FILE *fichero;
	int node=row*colum;
	int i,j;
	int nvel=9;
	float leer;
	
 	fichero = fopen("matriz_con_func_dist.txt","r");
	
	   if (fichero==NULL)
   	{
  	    printf( "No se puede abrir el fichero.\n" );
	      system("pause");
	      exit (EXIT_FAILURE);
	   }
	
	for(i=0;i<node;i++){

		for(j=0;j<nvel;j++){

			fscanf(fichero,"%f",&leer);	
			pmat[i][j]=leer;
			printf("%f",leer);
		}
	fscanf(fichero, "\n"); 
	}

	fclose(fichero);
}


//-------------Funcion llenar los vecinos

void llenarVecinos(int ** pmat, int row, int colum){
	FILE *fichero;
	int node=row*colum;
	int i,j;
	int nvec=9;
		

	
 	fichero = fopen("matriz_con_vecinos.txt","r");
	
	   if (fichero==NULL)
   	{
  	    printf( "No se puede abrir el fichero.\n" );
	      system("pause");
	      exit (EXIT_FAILURE);
	   }
	
	for(i=0;i<node;i++){

		for(j=0;j<nvec;j++){

			fscanf(fichero,"%i",&pmat[i][j]);	
		}
	fscanf(fichero, "\n"); 
	}


       
   fclose(fichero);
}

//-------------Funcion sumar velocidad

__global__ void sumarvelocidad(double ** pdist,int ** pvec,double ** psum, int node) {
int nvec=9;	//numero de vecinos
int ndist=9;	//numero de funcion de distribucion
int k;
int x = threadIdx.x + blockIdx.x * blockDim.x;
int y = threadIdx.y + blockIdx.y * blockDim.y;
// int offset = x + y * blockDim.x * gridDim.x;

if (x<node){ //para que se paralelice en cada nodo
	if (y<nvec){	//para que se paralelice en cada vecino
		for(k=0;k<ndist;k++){	//para cada velocidad realizo la suma al no saber como paralelizar esta parte
			psum[x][k]+=pdist[pvec[x][y]][k];				
						}
		}


		}

}

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
