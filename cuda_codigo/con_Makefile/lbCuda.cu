#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cuda_runtime.h>

#include "llenar_vecinos.h"


int main(int argc, char** argv) {


    int row=6;
    int colum=6;
    int node=row*colum;
    int nvec=9;
    int nvel=9;

    int *dev_vecinos;
    double *dev_velocidad;
    double *dev_suma;


    double *hst_velocidad;
    int *hst_vecinos;


    // reserva en el host
    hst_velocidad = (double*)malloc( node*nvel*sizeof(double) );
    hst_vecinos   = (int*)malloc( node*nvec*sizeof(int) );

    // reserva en el device
    cudaMalloc( (void**)&dev_velocidad, node*nvel*sizeof(double) );
    cudaMalloc( (void**)&dev_suma, node*nvel*sizeof(double) );
    cudaMalloc( (void**)&dev_vecinos, node*nvec*sizeof(int) );

    // inicializacion de datos
    llenarVecinos(&hst_vecinos, row, colum);



    // Liberacion de memoria

    cudaFree( dev_vecinos );
    cudaFree( dev_velocidad );
    cudaFree( hst_velocidad );

    free(hst_velocidad);
    free(hst_vecinos);


    return 0;
}
