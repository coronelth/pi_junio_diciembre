NVCC=nvcc

lbCuda: lbCuda.o llenar_vecinos.o
	$(NVCC) -o lbCuda lbCuda.o llenar_vecinos.o

lbCuda.o: lbCuda.cu
	$(NVCC) -c lbCuda.cu

llenar_vecinos.o: llenar_vecinos.cu
	$(NVCC) -c llenar_vecinos.cu

clean:
	rm *.o
