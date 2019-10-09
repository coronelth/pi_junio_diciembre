// includes

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cuda_runtime.h>

//-------------Funcion llenar la "velocidad"

void llenarVelocidad(int ** pmat, int row, int colum){
	FILE *fichero;
	int node=row*colum;
	int i,j;
	int nvel=9;
		

	
 	fichero = fopen("matriz_con_func_dist.txt","r");
	
	   if (fichero==NULL)
   	{
  	    printf( "No se puede abrir el fichero.\n" );
	      system("pause");
	      exit (EXIT_FAILURE);
	   }
	
	for(i=0;i<node;i++){

		for(j=0;j<nvel;j++){

			fscanf(fichero,"%i",&pmat[i][j]);	
		}
	fscanf(fichero, "\n"); 
	}

       
   fclose(fichero);


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


//-------------Funcion sumar velocidad

__device__ void sumarvelocidad(double ** pdist,int ** pvec,double ** psum, int node) {
int nvec=9;	//numero de vecinos
int ndist=9;	//numero de funcion de distribucion

int x = threadIdx.x + blockIdx.x * blockDim.x;
int y = threadIdx.y + blockIdx.y * blockDim.y;
int offset = x + y * blockDim.x * gridDim.x;

int j;

if (x<node){
	if (y<nvec){
		j=y;//para que una parte haga los vecinos y la otra parte calcule la suma de los 
		psum[x][k]+=pdist[pvec[x][j]][k];
		if ((y > nvec)&&(y < nvec+ndist )){
			psum[x][k]+=pdist[pvec[x][j]][k];			
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

int *dev_vecinos;
float *dev_matriz;
float *hst_matriz;


// reserva en el host
hst_matriz = (float*)malloc( node*nvec*sizeof(float) );

// reserva en el device
cudaMalloc( (void**)&dev_matriz, node*nvec*sizeof(float) );
cudaMalloc( (void**)&dev_vecinos, node*nvec*sizeof(int) );

// inicializacion de datos


/*
// copia de datos
cudaMemcpy(dev_matriz, hst_matriz, N*N*sizeof(float), cudaMemcpyHostToDevice);
// salida
*/


cudaFree( dev_vecinos )
cudaFree( dev_matriz )
cudaFree( hst_matriz )


return 0;
}
