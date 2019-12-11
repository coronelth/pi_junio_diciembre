NVCC=nvcc

#CUDAFLAGS= -arch=sm_30
CUDAFLAGS=

# OPT= -g -G
OPT=

# # RM=/bin/rm -f

 # all: IC


main: cu_codigo.o todo_el_resto_de_los_.o

 	${NVCC} ${OPT} -o main cu_codigo.o llenar_vel.o llenar_vec.o sumar_vel.o

llenar_vec.o: llenar_vec.cu

	${NVCC} ${OPT} ${CUDAFLAGS} -c llenar_vec.cu

llenar_vel.o: llenar_vel.cu

	${NVCC} ${OPT} ${CUDAFLAGS} -c llenar_vel.cu

sumar_vel.o: sumar_vel.cu

	${NVCC} ${OPT} ${CUDAFLAGS} -c sumar_vel.cu

 cu_codigo.o: cu_codigo.cu

	$(NVCC) ${OPT} $(CUDAFLAGS) -c cu_codigo.cu

cu_codigo: cu_codigo.o todo_el_resto_de_los_.o

	$NVCC} ${CUDAFLAGS} -o cu_codigo cu_codigo.o todo_el_resto_de_los_.o

clean:

        ${RM} *.o IC
