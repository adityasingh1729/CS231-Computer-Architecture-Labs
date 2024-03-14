import numpy as np
import matplotlib.pyplot as plt

X = ['LRU', 'FIFO', 'LFU', 'BIP_0', 'BIP_0.25', 'BIP_0.5', 'BIP_0.75', 'BIP_1']

'''
Y_602 = [73.09,74.49,73.38,81.86,84.12,84.12,84.13,81.86]
Y_603 = [85.24,85.20,87.34,87.39,87.52,87.50,87.52,87.40]
Y_619 = [35.55,34.48,85.27,85.62,85.44,85.62,85.44,85.56]
Y_sss = [71.90,73.47,78.70,82.65,88.94,88.39,86.99,82.65]
Y_bc  = [79.08,79.66,85.83,94.30,94.30,94.30,94.30,94.30]
'''

Y_602 = [1,1.0007,1.002,1,1,1,1,1]
Y_603 = [1,0.994,0.996,1,0.999,0.999,0.999,1]
Y_619 = [1,1.0022,1.0018,1.0022,1.0050,1.0022,1.0050,1.0040]
Y_sss = [1,1.0005,1.0813,1.1330,1.0118,1.0184,1.0371,1.1330]
Y_bc  = [1,1.0014,1.0604,1.0021,1.0021,1.0021,1.0021,1.0021]

X_axis = np.arange(len(X))

plt.bar(X_axis - 0.3, Y_602, 0.1, label='602')
plt.bar(X_axis - 0.2, Y_603, 0.1, label='603')
plt.bar(X_axis - 0.1, Y_619, 0.1, label='619')
plt.bar(X_axis, Y_sss, 0.1, label='sss')
plt.bar(X_axis + 0.1, Y_bc, 0.1, label='bc')

plt.xticks(X_axis, X)
plt.xlabel("Policies and Traces")
plt.ylabel("Speedup Achieved")
plt.title("Trend of Speedup for Different Traces and Replacement Policies")
plt.legend()
plt.ylim(0.8,1.2)
plt.show()
