#include <stdio.h>
#include <stdlib.h>

void liberaVector(float *vec) {
free(vec);
return;
}
