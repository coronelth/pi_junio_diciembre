#include <assert.h>

void guardar_suma(float *pmat,int node, int ndist ){

// Guardar el archivo en un .txt
//-----------------------------------------------


FILE *f = fopen("suma_de_coliciones.txt", "w");
if (f == NULL)
{
    printf("Error opening file!\n");
    exit(1);
}

for(i=0;i<node;i++){
	for(j=0;j<nvel;j++){
		fprintf(f,"%f\t",pmat[i*ndist+j] );
		}
		
	fprintf(f,"\n");
	
}

fclose(f);

	return 0;
}
