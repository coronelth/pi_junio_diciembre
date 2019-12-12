NVCC=nvcc

hacer_pelota: hacer_pelota.o llenar_vecinos.o alloca_vecinos.o libera_vecinos.o libera_vector.o alloca_vector.o llenar_velocidad.o sumar_velocidad.o guardar_suma.o densidad_suma_doble_if.o
	$(NVCC) -o hacer_pelota hacer_pelota.o llenar_vecinos.o alloca_vecinos.o libera_vecinos.o libera_vector.o alloca_vector.o llenar_velocidad.o sumar_velocidad.o guardar_suma.o densidad_suma_doble_if.o

hacer_pelota.o: hacer_pelota.cu
	$(NVCC) -c hacer_pelota.cu

alloca_vecinos.o: alloca_vecinos.cu
	$(NVCC) -c alloca_vecinos.cu

llenar_vecinos.o: llenar_vecinos.cu
	$(NVCC) -c llenar_vecinos.cu

libera_vecinos.o: libera_vecinos.cu
	$(NVCC) -c libera_vecinos.cu

alloca_vector.o: alloca_vector.cu
	$(NVCC) -c alloca_vector.cu

libera_vector.o: libera_vector.cu
	$(NVCC) -c libera_vector.cu

llenar_velocidad.o: llenar_velocidad.cu
	$(NVCC) -c llenar_velocidad.cu

sumar_velocidad.o: sumar_velocidad.cu
	$(NVCC) -c sumar_velocidad.cu

guardar_suma.o: guardar_suma.cu
	$(NVCC) -c guardar_suma.cu

densidad_suma_doble_if.o: densidad_suma_doble_if.cu
	$(NVCC) -c densidad_suma_doble_if.cu
clean:
	rm *.o
