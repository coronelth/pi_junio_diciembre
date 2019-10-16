#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>


// Funciones de alocacion y liberacion de memoria

double *allocaVector(double n) {
	double *v = (double *) malloc(n * sizeof(double));
	assert(v != NULL);
	return v;
}

void liberaVector(double *vec) {
free(vec);
return;
}

//matriz distribicion y matriz de suma
void liberaMatriz(double** pmat, int node) {
	int i;
	for( i=0; i<node; i++)
		free(pmat[i]);
		free(pmat);
	return;
	}
double ** allocaMatriz(int node, int nveloc) {	
	int i;
	double **pmat;
	pmat = (double **) malloc(node * sizeof(double*));
	if( pmat == NULL )
	return NULL; 

	for( i=0; i<node; i++){
		pmat[i]=(double *) malloc(nveloc * sizeof(double));
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

void llenarVelocidad(double ** pmat, int row, int colum){
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
   printf( "Contenido del fichero:\n" );
   for (i = 0; i < node; i++) {
      for (j = 0; j < nvel; j++)
	 printf ("%f ", pmat[i][j]);
      printf ("\n");
   }

       
   
}
	
// Sumar velocidades

void sumarVelocidad(double ** pdist,int ** pvec,double ** psum, int node){
	int i,j,k;	
	
	for(i=0;i<node;i++)	//para cada nodo
		for(j=0;j<9;j++)	//para cada vecino (son 9)
			for(k=0;k<9;k++){	//para cada velocidad
			
			psum[i][k]+=pdist[pvec[i][j]][k];			
	}	
}

//*****************-----------------------------********************************--------------------*********************************

int main(void){


	
	
// Definicion de las dimensiones de mi problema
	int row=6;
	int colum=6;
	int node= row*colum;
	int nveloc=9;
	int nvec=9;
	
	clock_t t_ini, t_fin;
	double secs;

// Alocacion de las matrices de mi problema	
	double** matdist = allocaMatriz(node,nveloc);
	double** matsum = allocaMatriz(node,nveloc);
	int** matvec = allocaVecinos(node,nvec);

//Inicializacion de los valores
	llenarVelocidad(matdist,row,colum);
	llenarVecinos(matvec,row,colum);	

//Suma de los valores de la velocidad
// Tomas de tiempo

	t_ini = clock();
	sumarVelocidad(matdist,matvec,matsum,node);
	t_fin = clock();
	

 	secs = (double)(t_fin - t_ini) / CLOCKS_PER_SEC;
	printf("%.16g milisegundos\n", secs * 1000.0);   	


//Liberaci´on de memoria

liberaMatriz(matdist,node);
liberaMatriz(matsum,node);
liberaVecinos(matvec,node);

return 0;
}










