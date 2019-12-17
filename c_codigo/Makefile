GCC=gcc

lattice_reducido: lattice_reducido.o alloca_vector.o alloca_vecinos.o alloca_matriz.o libera_vector.o libera_matriz.o libera_vecinos.o llenar_vecinos.o llenar_velocidad.o sumar_velocidad.o guardar_suma.o generator_mat_dist.o generator_mat_vecinos.o
	$(GCC) -o lattice_reducido lattice_reducido.o alloca_vector.o alloca_vecinos.o alloca_matriz.o libera_vector.o libera_matriz.o libera_vecinos.o llenar_vecinos.o llenar_velocidad.o sumar_velocidad.o guardar_suma.o generator_mat_dist.o generator_mat_vecinos.o

lattice_reducido.o: lattice_reducido.c
	$(GCC) -c lattice_reducido.c

alloca_vector.o: alloca_vector.c
	$(GCC) -c alloca_vector.c

alloca_vecinos: alloca_vecinos.o libera_vecinos.o
	$(GCC) -o alloca_vecinos alloca_vecinos.o libera_vecinos.o 

alloca_vecinos.o: alloca_vecinos.c
	$(GCC) -c alloca_vecinos.c

alloca_matriz: alloca_matriz.o libera_matriz.o
	$(GCC) -o alloca_matriz alloca_matriz.o libera_matriz.o 

alloca_matriz.o: alloca_matriz.c
	$(GCC) -c alloca_matriz.c

libera_vector.o: libera_vector.c
	$(GCC) -c libera_vector.c

libera_matriz.o: libera_matriz.c
	$(GCC) -c libera_matriz.c

libera_vecinos.o: libera_vecinos.c
	$(GCC) -c libera_vecinos.c

llenar_vecinos.o: llenar_vecinos.c
	$(GCC) -c llenar_vecinos.c

llenar_velocidad.o: llenar_velocidad.c
	$(GCC) -c llenar_velocidad.c

sumar_velocidad.o: sumar_velocidad.c
	$(GCC) -c sumar_velocidad.c

guardar_suma.o: guardar_suma.c
	$(GCC) -c guardar_suma.c

generator_mat_dist.o: generator_mat_dist.c
	$(GCC) -c generator_mat_dist.c

generator_mat_vecinos.o: generator_mat_vecinos.c
	$(GCC) -c generator_mat_vecinos.c



clean:
	rm *.o





