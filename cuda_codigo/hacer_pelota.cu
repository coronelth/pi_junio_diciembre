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
			//printf("%f",leer);
		}
	fscanf(fichero, "\n"); 
	}
	
	fclose(fichero);

//--------------------------------------------------------------------------------------------------------------------------------------


    

//---------------------------------------------------- COMPROBACION DE QUE ESTA LEYENDO CORRECTAMENTE-----------------------------------
  /*  printf( "Contenido del fichero:\n" );
   for (i = 0; i < node; i++) {
      for (j = 0; j < nvel; j++)
	 printf ("%f ", pmat[i][j]);
      printf ("\n");
   }*/

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

//---------------------------------------------------- COMPROBACION DE QUE ESTA LEYENDO CORRECTAMENTE-----------------------------------

/*   printf( "Contenido del fichero:\n" );
   for (i = 0; i < node; i++) {
      for (j = 0; j < nvec; j++)
	 printf ("%d ", pmat[i][j]);
      printf ("\n");
   }*/

   return ;
}


//matriz de vecinos
void liberaVecinos(int ** pmat, int node) {
	int i;
	for( i=0; i<node; i++)
		free(pmat[i]);
		free(pmat);
	return;
	}

int ** allocaVecinos(int node, int nvecinos) {	
	int i;
	int **pmat;
	pmat = (int **) malloc(node * sizeof(int*));
	if( pmat == NULL )
	return NULL; 

	for( i=0; i<node; i++){
		pmat[i]=(int *) malloc(nvecinos * sizeof(int));
			if( pmat[i] == NULL ){
				liberaVecinos(pmat,i);
	return NULL;
	}
	}
	return pmat;
}


//matriz distribicion y matriz de suma
void liberaMatriz(float** pmat, int node) {
	int i;
	for( i=0; i<node; i++)
		free(pmat[i]);
		free(pmat);
	return;
	}
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



//-------------Funcion sumar velocidad

__global__ void sumarvelocidad(float ** pdist,int ** pvec,float ** psum, int node) {
int nvec=9;	//numero de vecinos
int ndist=9;	//numero de funcion de distribucion
int k=0;
int x = threadIdx.x + blockIdx.x * blockDim.x;
int y = threadIdx.y + blockIdx.y * blockDim.y;
printf("Estoy en el kernel \n\n\n\n");
if (x<node){ //para que se paralelice en cada nodo
	if (y<nvec){	//para que se paralelice en cada vecino
		for(k=0;k<ndist;k++){	//para cada velocidad realizo la suma al no saber como paralelizar esta parte
			psum[x][k]+=pdist[pvec[x][y]][k];				
						}
		}


		}
printf("Termine el kernel \n\n\n\n");
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
float *dev_velocidad;
float *dev_suma;



// reserva en el host

int** hst_vecinos   = allocaVecinos(node,nvec);
float** hst_velocidad = allocaMatriz(node,nvel);
float** hst_suma      = allocaMatriz(node,nvel);


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
	sumarvelocidad<<<16,256>>>(&dev_velocidad, &dev_vecinos, &dev_suma, node);
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


cudaFree( dev_vecinos );
cudaFree( dev_velocidad );
cudaFree( hst_velocidad );

liberaMatriz(hst_suma,node);
liberaMatriz(hst_velocidad,node);
liberaVecinos(hst_vecinos,node);

return 0;
}
