#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>

#include "alloca_vector.h"
#include "alloca_vecinos.h"
#include "alloca_matriz.h"

#include "libera_vector.h"
#include "libera_matriz.h"
#include "libera_vecinos.h"

#include "llenar_vecinos.h"
#include "llenar_velocidad.h"
#include "llenar_suma.h"

#include "sumar_velocidad.h"
#include "guardar_suma.h"

#include "generator_mat_vecinos.h"
#include "generator_mat_dist.h"


//*****************-----------------------------********************************

int main(void){
	
// Definicion de las dimensiones de mi problema
	int row=512;
	int colum=512;
	int node= row*colum;
	int nveloc=9;
	int nvec=9;
	int one=1;
	int i;
	int num_prom = 1000 ;	

	clock_t t_ini, t_fin;
	float secs;

// Alocacion de las matrices de mi problema	
	float** matdist = allocaMatriz(node,nveloc);
	float** matsum = allocaMatriz(node,one);
	int** matvec = allocaVecinos(node,nvec);

// Generacion de la matriz de vecinos y pdist

	generator_matriz_dist (row, colum);
	generator_matriz_vecinos (row, colum);


//Inicializacion de los valores
	llenarVelocidad(matdist,row,colum);
	llenarVecinos(matvec,row,colum);	
	llenarSuma(matsum,row,colum);			
//Suma de los valores de la velocidad
// Tomas de tiempo

	float sec_prom = 0.0;

for(i=0;i<num_prom;i++){	

	llenarSuma(matsum,row,colum);
	t_ini = clock();
	sumarVelocidad(matdist,matvec,matsum,node);
	t_fin = clock();
 	secs = (float)(t_fin - t_ini) / CLOCKS_PER_SEC;
	sec_prom += secs;
	}
	sec_prom = sec_prom/num_prom;
	
	printf ("\n\n\n");
	printf("%.16g milisegundos\n", sec_prom * 1000.0);   
	printf ("\n\n\n");

// guardamos la suma obtenida en un archivo txt


/*
    printf( "Contenido de matsum:\n" );
   for (i = 0; i < node; i++) {
      	 printf ("%f ", matsum[i][0]);
      printf ("\n");
   }
printf ("\n\n\n");
*/

guardar_suma(matsum,node, one);

//Liberaci´on de memoria

liberaMatriz(matdist,node);
//liberaMatriz(matsum,node);
//liberaVecinos(matvec,node);

return 0;
}










