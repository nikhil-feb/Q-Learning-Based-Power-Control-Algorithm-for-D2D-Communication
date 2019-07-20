import numpy as np
import matplotlib.pyplot as plt
import communication_utility

R = 500  # MACRO CELL RADIUS in meters
M = 30  # CELLULAR USERS
N = 12  # D2D USERS
L0 = 6  # least SINR of cellular user in db
alpha = 0.5  # learning rate
eta = 0.9  # discount factor
epsilon = 0.1  # greedy strategy
P_max = 23  # max power that can be transmitted by user in dbm
noise = -116  # noise power in dbm
d2d_distance = 50  # D2D pair distance
L = 10  # power levels
p_max = communication_utility.dbm_to_pow(P_max)  # d2d max power in watts
noise_pow = communication_utility.dbm_to_pow(noise)  # noise power in watts
p_min = communication_utility.db_to_pow(L0)*noise_pow  # d2d min power in watts
P_min = L0 + noise
action_size = 12 # number of actions
# states
state_size = 2 * N
# actions
p_levels = np.arange(P_min,P_max,action_size)
# rewards
Q = np.zeros((state_size, action_size))

print(p_levels)
print('q table')
print(Q)