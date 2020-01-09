#%%
import numpy as np
from time import time

mat_dist = np.loadtxt('pi_junio_diciembre/c_codigo/matriz_con_func_dist.txt')
mat_vec  = np.loadtxt('pi_junio_diciembre/c_codigo/matriz_con_vecinos.txt').astype(int)

#%%
nvec = mat_vec.shape[1]
ndist = mat_dist.shape[1]
time_prom = 0
n_prom = 100
#%%
for i in range (n_prom):
    time_init = time()
    suma_dist = np.sum(mat_dist, axis=1)
    time_final = time()

    total_time = time_final - time_init
    time_prom += total_time

time_prom /=n_prom

print("\n tiempo de ejecución: {} segundos ".format(time_prom))
