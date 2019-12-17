
#%%
import numpy as np 
import matplotlib.pyplot as plt

#%%
#se fueron realizando las corridas y se lleno a mano estos datos

time_c = np.array([ ])
time_cu = np.array([ ])
count_nodes = np.array([ ])


#%%
plt.fig()
plt.plot(count_nodes,time_c)
plt.plot(count_nodes,time_cu)
