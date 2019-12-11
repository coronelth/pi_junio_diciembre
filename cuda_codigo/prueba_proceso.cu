// includes

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cuda_runtime.h>

//-------------Funcion llenar "velocidad"

void llenarVelocidad(float ** pmat, int row, int colum){
	FILE *fichero;
	int node=row*colum;
	int i,j;
	int nvel=9;
	float leer;

	//float **pmat = NULL;	

 	fichero = fopen("matriz_con_func_dist.txt","r");
	
	   if (fichero==NULL)
   	{
  	    printf( "No se puede abrir el fichero.\n" );
	      system("pause");
	      exit (EXIT_FAILURE);
	   }


	printf("\nEstoy por leer del archivo matriz_con_func_dist.txt \n");		
	
	for(i=0;i<node;i++){
		
		printf("Estoy por entrar al for con i...");

		for(j=0;j<nvel;j++){

			fscanf(fichero,"%f",&leer);
			printf("Imprimo leer= %f  y cargo pmat[i][j]");	
			pmat[i][j]=leer;
			printf("%f",leer);
		}
	fscanf(fichero, "\n"); 
	}

	fclose(fichero);

	for(i=0;i<node;i++){
		for(j=0;j<nvel;j++){
			printf("%f\t",pmat[i][j]);
		}
	}
}


//-------------Funcion llenar los vecinos

int ** llenarVecinos(***pmat,int row, int colum){
	FILE *fichero;
	int node=row*colum;
	int i,j;
	int nvec=9;
	int aux=0;
	
//	int *hst_vecinos;
//	cudaMalloc( (void**)&hst_vecinos, node*nvec*sizeof(int) );

	int k=0;

	/*pmat[k]=0;*/

 	fichero = fopen("matriz_con_vecinos.txt","r");
	
	   if (fichero==NULL)
   	{
  	    printf( "No se puede abrir el fichero.\n" );
	      system("pause");
	      exit (EXIT_FAILURE);
	   }
	
	for(i=0;i<node;i++){

		for(j=0;j<nvec;j++){

			fscanf(fichero,"%d", &aux);  
			/*fscanf(fichero,"%d", &pmat[k]);*/
			/* printf("%d\t",pmat[k]); */
			printf("%d\t",aux); 
			*pmat[i][j]=aux;
			//&hst_vecinos[i][j] = aux;
			//printf("%d\t",(pmat[i])[j]);
			k=k+1;

		}
	printf("\n");
	fscanf(fichero, "\n"); 
	
	}
	
	
   printf( "\n\nTermine de tomar los valores del txt.\n\n\n" );
   fclose(fichero);

	for(i=0;i<node;i++){

		for(j=0;j<nvec;j++){
			//hst_vecinos[i] = 5;
			printf("%d\t", pmat[i][j]); 
			
		}
	printf("\n");

	}
return &hst_vecinos;

}

//-------------Funcion sumar velocidad

__global__ void sumarvelocidad(float ** pdist,int ** pvec,float ** psum, int node) {
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

int *hst_vecinos;
int *dev_vecinos;
float *dev_velocidad;
float *dev_suma;
float *hst_velocidad;


// reserva en el host
hst_velocidad = (float*)malloc( node*nvel*sizeof(float) );

// reserva en el device
cudaMalloc( (void**)&dev_velocidad, node*nvel*sizeof(float) );
cudaMalloc( (void**)&dev_suma, node*nvel*sizeof(float) );
cudaMalloc( (void**)&hst_vecinos, node*nvec*sizeof(int) );

// inicializacion de datos
printf("Llamo a llenarVecinos \n");
llenarVecinos(&hst_vecinos, row, colum);

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

	printf("Llamo al Kernel \n");

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
