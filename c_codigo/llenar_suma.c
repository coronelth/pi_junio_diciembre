#include <stdio.h>
#include <stdlib.h>

// LLenar Vecinos

void llenarSuma(float ** pmat, int row, int colum){
	int node=row*colum;
	int i,j;
	int ndist=9;
		
	for(i=0;i<node;i++){

		for(j=0;j<ndist;j++){

			pmat[i][j]=0.0;	
		}

	}
  

/*
//---------------------------------------------------- COMPROBACION DE QUE ESTA LEYENDO CORRECTAMENTE-----------------------------------
   printf( "Contenido de SUMA:\n" );
   for (i = 0; i < node; i++) {
      for (j = 0; j < ndist; j++)
	 printf ("%f ", pmat[i][j]);
      printf ("\n");
   }
*/
   return ;
}
