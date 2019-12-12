#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>


// Funciones de alocacion y liberacion de memoria

float *allocaVector(float n) {
	float *v = (float *) malloc(n * sizeof(float));
	assert(v != NULL);
	return v;
}

void liberaVector(float *vec) {
free(vec);
return;
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


//-------------------------------------------------------------------------------------------------------------------------------------



// LLenar Vecinos

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
  /* printf( "Contenido del fichero:\n" );
   for (i = 0; i < node; i++) {
      for (j = 0; j < nvec; j++)
	 printf ("%d ", pmat[i][j]);
      printf ("\n");
   }*/

   return ;
}

//-------------------------------------------------------------------------------------------------------------------------------------

// Llenar velocidad

void llenarVelocidad(float ** pmat, int row, int colum){
	FILE *fichero;
	int node=row*colum;
	int i,j;
	int nvel=9;
	int height, width;
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
   /* printf( "Contenido del fichero:\n" );
   for (i = 0; i < node; i++) {
      for (j = 0; j < nvel; j++)
	 printf ("%f ", pmat[i][j]);
      printf ("\n");
   }
*/
}      


	
// Sumar velocidades

void sumarVelocidad(float ** pdist,int ** pvec,float ** psum, int node){
	int i,j;	
	int nvec=9;
	int nvel=9;

	for(i=0;i<node;i++){	//para cada nodo
		for(j=0;j<nvel;j++){	//para cada velocidad
			psum[i][0]+=pdist[i][j];			
	}	
}
}


void guardar_suma(float **pmat,int node, int ndist ){

// Guardar el archivo en un .txt
//-----------------------------------------------
int i;
int j;

FILE *f = fopen("suma_de_coliciones.txt", "w");
if (f == NULL)
{
    printf("Error opening file!\n");
    exit(1);
}

for(i=0;i<node;i++){
	for(j=0;j<ndist;j++){
		fprintf(f,"%f\t",pmat[i][j] );
		}
		
	fprintf(f,"\n");
	
}

fclose(f);

	return ;
}


//*****************-----------------------------********************************--------------------*********************************

int main(void){


	
	
// Definicion de las dimensiones de mi problema
	int row=6;
	int colum=6;
	int node= row*colum;
	int nveloc=9;
	int nvec=9;
	int one=1;
	
	clock_t t_ini, t_fin;
	float secs;

// Alocacion de las matrices de mi problema	
	float** matdist = allocaMatriz(node,nveloc);
	float** matsum = allocaMatriz(node,one);
	int** matvec = allocaVecinos(node,nvec);

//Inicializacion de los valores
	llenarVelocidad(matdist,row,colum);
	llenarVecinos(matvec,row,colum);	

//Suma de los valores de la velocidad
// Tomas de tiempo

	t_ini = clock();
	sumarVelocidad(matdist,matvec,matsum,node);
	t_fin = clock();
	

 	secs = (float)(t_fin - t_ini) / CLOCKS_PER_SEC;
	printf("%.16g milisegundos\n", secs * 1000.0);   

// guardamos la suma obtenida en un archivo txt


int i;
    printf( "Contenido de matsum:\n" );
   for (i = 0; i < node; i++) {
      	 printf ("%f ", matsum[i][0]);
      printf ("\n");
   }
printf ("\n\n\n");





guardar_suma(matsum,node, one);

//Liberaci´on de memoria

liberaMatriz(matdist,node);
liberaMatriz(matsum,node);
liberaVecinos(matvec,node);

return 0;
}










