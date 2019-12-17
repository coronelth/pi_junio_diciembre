
#%%
import numpy as np 
import matplotlib.pyplot as plt

#%%
#se fueron realizando las corridas y se lleno a mano estos datos

time_c = np.array([ 0.004644005002774065 , 0.007740986802673433 , 0.01064687967300415, 0.01064687967300415,
                   0.02591622796899173, 0.05133263402967714, 0.1031133288051933, 0.2052466152235866, 0.4070098511874676,
                   0.8171154768206179 , 1.650304882787168, 3.298251423984766, 6.619902793318033])

time_cu_1_if = np.array([ 0.014029,0.015070 , 0.014609,  0.016189,0.016706,
                         0.019474,0.019263,0.027797,0.040942,0.041483,
                         0.041853,0.041387,0.036083])
time_cu_2_if = np.array([ 0.008324, 0.008216, 0.008330 ,0.008358,0.008749,
                         0.015766,0.014185,0.016221,0.018397,0.018793,
                         0.018914,0.018899,0.018895])
count_nodes = np.array([ (2**6) ,(2**7), (2**8) ,(2**9) ,(2**10) ,(2**11) ,(2**12) ,(2**13), (2**14) ,(2**15), (2**16), (2**17), (2**18) ])


#%%
# 8*8 ; 8*16 :16*16;16*32 ;32*32;32*64;64*64;128*64;128*128;128*256;256*256;256*512;512*512
#
#%%
plt.figure()
plt.plot(count_nodes,time_c,label='C')
plt.plot(count_nodes,time_cu_1_if,label='CUDA C 1 IF')
plt.plot(count_nodes,time_cu_2_if,label='CUDA C 2 IF')
plt.legend()
plt.title('Comparacion de C y CUDA C',fontsize=14)
plt.xlabel('Number of nodes',fontsize=14)
plt.ylabel('Time of execution',fontsize=14)
plt.xticks(fontsize=14)
plt.yticks(fontsize=14)
plt.xscale('log') 
plt.grid(True)
plt.savefig('Preliminar_nodo_vs_time_c_cuda.png')
plt.close

plt.figure()
plt.plot(count_nodes,time_cu_1_if,label='CUDA C 1 IF')
plt.plot(count_nodes,time_cu_2_if,label='CUDA C 2 IF')
plt.legend()
plt.title('Comparacion de dos kernels de CUDA',fontsize=14)
plt.xlabel('Number of nodes',fontsize=14)
plt.ylabel('Time of execution',fontsize=14)
plt.xticks(fontsize=14)
plt.yticks(fontsize=14)
plt.xscale('log') 
plt.grid(True)
plt.savefig('Preliminar_nodo_vs_time_cuda_c.png')
plt.close