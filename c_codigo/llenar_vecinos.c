#include <stdio.h>
#include <stdlib.h>

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
