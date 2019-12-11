#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cuda_runtime.h>


//-------------Funcion llenar los vecinos

void llenarVecinos(int ** pmat, int row, int colum){
    
    FILE *fichero;
    int node=row*colum;
    int i,j;
    int nvec=9;
    int aux=0;

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
			
	    pmat[i][j]=aux;
	    printf("%d\t",pmat[i][j]);
	    k=k+1;

	}
/*	printf("\n");*/
	fscanf(fichero, "\n");
    }


       
    fclose(fichero);
}
