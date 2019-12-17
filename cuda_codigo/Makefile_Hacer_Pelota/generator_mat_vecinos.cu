// Codigo para realizar un .txt donde tenga guardado los vecinos de los puntos de la grilla
//Para ello tengo que pasarle como argumento el numero de columnas y filas de mi grilla


#include <stdio.h>
#include <stdlib.h>

void generator_matriz_vecinos (int row, int colum){


// donde row y colum son del problema fisico real que me marcan la grilla

//Declaracion de variables	
//----------------------------------------------------------------
	int node=row*colum;
	int nvec=9; // son la cantidad de vecinos que puede tener un punto de la grilla (contandose a si mismo)
	
	int i,j;
	int** pmat;
	
//Allocacion de la matriz con los parametros
//-----------------------------------------------------------------
	pmat=(int **) malloc(node * sizeof(int*));

	for( i=0; i<node; i++){
		pmat[i]=(int *) malloc(nvec * sizeof(int));
	}

//Empieza el rellenado de los vecinos, esto tiene que ver con la primera forma (cruz y luego diagonales)
	
	for(i=0;i<node;i++){
				
			// rellenado para un lugar en el centro
			pmat[i][0]=i;
			pmat[i][1]=i+1;
			pmat[i][2]=i+colum;
			pmat[i][3]=i-1;
			pmat[i][4]=i-colum;
			pmat[i][5]=i+colum+1;
			pmat[i][6]=i+colum-1;
			pmat[i][7]=i-colum-1;
			pmat[i][8]=i-colum+1;

			// se encuentra en el borde izquierdo
			if ((i%colum)==0){
				pmat[i][3]=0;
				pmat[i][6]=0;
				pmat[i][7]=0;
			}

			// se encuentra en el borde derecho
			if (((i+1)%colum)==0){
				pmat[i][1]=0;
				pmat[i][5]=0;
				pmat[i][8]=0;
			}

			// se encuentra en el borde inferior
			if (i < colum) {
				pmat[i][4]=0;
				pmat[i][7]=0;
				pmat[i][8]=0;
			}

			// se encuentra en el borde superior
			if ((i<(colum*row)) && (i>=(colum*row-colum))){
				pmat[i][2]=0;
				pmat[i][5]=0;
				pmat[i][6]=0;
			}
			// con la implementacion de estas cuatro condiciones tambien tengo incluido las puntas (hay que ver bien que valor adoptan si 0 o -1
			// porque el valor de 0 me da la direccion de uno de los nodos, hay que ver la implementacion del -1 y que pasa en el resto del codigo)			

	}

// Guardar el archivo en un .txt
//-----------------------------------------------


FILE *f = fopen("matriz_con_vecinos.txt", "w");
if (f == NULL)
{
    printf("Error opening file!\n");
    exit(1);
}


for(i=0;i<node;i++){
	for(j=0;j<nvec;j++){
		fprintf(f,"%i\t",pmat[i][j] );
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
	return ;



}
