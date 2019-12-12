#include <stdio.h>
#include <stdlib.h>

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
