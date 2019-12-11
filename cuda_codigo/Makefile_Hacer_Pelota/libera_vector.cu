// includes

#include <stdio.h>
#include <stdlib.h>

// Funcion de liberacion de memoria para el vector que representa la Matriz

void liberaVector(float *vec) {
free(vec);
return;
}
