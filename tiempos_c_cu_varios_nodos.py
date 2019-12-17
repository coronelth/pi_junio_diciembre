
#%%
import numpy as np 
import matplotlib.pyplot as plt

#%%
#se fueron realizando las corridas y se lleno a mano estos datos

time_c = np.array([ 0.004644005002774065 , 0.007740986802673433 , 0.01064687967300415, 0.01064687967300415,
                   0.02591622796899173, 0.05133263402967714, 0.1031133288051933, 0.2052466152235866, 0.4070098511874676,
                   0.8171154768206179 , 1.650304882787168, 3.298251423984766, 6.619902793318033])

time_cu_1_if = np.array([ ])
time_cu_2_if = np.array([ ])
count_nodes = np.array([ (2**6) (2**7) (2**8) (2**9) (2**10) (2**11) (2**12) (2**13) (2**14) (2**15) (2**16) (2**17) (2**18) ])

ind=np.arange(6,14,1)
count_nodes = np.ones((1,13))*2

#%%
# 8*8 ; 8*16 :16*16;16*32 ;32*32;32*64;64*64;128*64;128*128;128*256;256*256;256*512;512*512
#
#%%
plt.fig()
plt.plot(count_nodes,time_c,label='C',linewidth=3.5)
plt.plot(count_nodes,time_cu_1_if,label='CUDA C 1 IF',linewidth=3.5)
plt.plot(count_nodes,time_cu_2_if,label='CUDA C 2 IF',linewidth=3.5)
plt.legend()
plt.title('Accuracy with CIFAR-100  AlexNet arquitecture',fontsize=14)
plt.xlabel('Number of nodes',fontsize=14)
plt.ylabel('Time of execution',fontsize=14)
plt.xticks(fontsize=14)
plt.yticks(fontsize=14)
plt.grid(True)
plt.savefig('Preliminar_nodo_vs_time.png')
plt.close