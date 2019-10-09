// Codigo para realizar un .txt donde tenga guardado los valores de la funcion distribucion, asi pueda comparar que todos los datos sean los mismos con los diferentes codigos
//Para ello tengo que pasarle como argumento el numero de columnas y filas de mi grilla


#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>

int main (void){

// donde row y colum son del problema fisico real que me marcan la grilla

//Declaracion de variables	
//----------------------------------------------------------------
	int row=6;
	int colum=6;
	int node=row*colum;
	int nvel=9; // son la cantidad de valores que posee cada nodo como funcion de distribucion
	
	int i,j;
	double** pmat;
	
//Allocacion de la matriz con los parametros
//-----------------------------------------------------------------
	pmat=(double **) malloc(node * sizeof(double*));

	for( i=0; i<node; i++){
		pmat[i]=(double *) malloc(nvel * sizeof(double));
	}

//Empieza el rellenado de los valores, se realizara mediante numeros aleatorios
	
	
	for(i=0;i<node;i++){
		for(j=0;j<nvel;j++){
			if (j==0)
			pmat[i][j]=0;
						
		pmat[i][j]=drand48();
		}
	}


	
// Guardar el archivo en un .txt
//-----------------------------------------------


FILE *f = fopen("matriz_con_func_dist.txt", "w");
if (f == NULL)
{
    printf("Error opening file!\n");
    exit(1);
}


for(i=0;i<node;i++){
	for(j=0;j<nvel;j++){
		fprintf(f,"%f\t",pmat[i][j] );
		}
		
	fprintf(f,"\n");
	
}

fclose(f);


//Liberacion memoria

	for( i=0; i<node; i++){
		free(pmat[i]);
		//free(pmat);
	}
//--------------------------------------------------
	return 0;



}
