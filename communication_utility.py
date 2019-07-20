import numpy as np
import math
import matplotlib.pyplot as plt

def sinr(pow_array,noise_pow):
    sinr_array = np.zeros(pow_array.shape)
    total_pow = sum(pow_array)
    for i in range(len(pow_array)):
        sinr_array[i] = pow_array[i] / (noise_pow[i] + total_pow - pow_array[i])
    return sinr_array


def dbm_to_pow(x):
    '''
    :param x: power in dbm
    :return: converts dbm to watt power
    '''
    return 0.001 * (10 ** (x/10))


def db_to_pow(x):
    '''
    :param x: power in db
    :return: converts dbm to watt power
    '''
    return 10 ** (x/10)


def capacity(s,i,n):
    '''
    :param s: signal power
    :param i: interference power
    :param n: noise power
    :return: returns the capacity
    '''
    return math.log2(1+(s/(i+n)))

def d2d_points(no_d2d,max_radius,min_dis):
    num = 0
    fx = np.zeros(no_d2d)
    fy = np.zeros(no_d2d)
    while num < no_d2d:
        in_x = np.random.uniform(-max_radius,max_radius)
        in_y = np.random.uniform(-max_radius, max_radius)
        if in_x**2 + in_y**2 <= max_radius ** 2:
            in_dis = False
            i = 0
            while i < no_d2d:
                if (in_x-fx[i])**2 + (in_y-fy[i])**2 < min_dis**2:
                    in_dis = True
                    break
                i+=1
            if in_dis == False:
                fx[num] = in_x
                fy[num] = in_y
                num+=1
    return fx,fy
def circle(radius,c_x,c_y):
    t = np.arange(0,2*np.pi,0.01)
    x = c_x + radius*np.sin(t)
    y = c_y + radius*np.cos(t)
    return x,y

if __name__=='__main__':
    no_d2d = 12
    max_radius = 500
    min_dis = 50
    x,y = d2d_points(no_d2d,max_radius,min_dis)
    c_x,c_y = circle(max_radius,0,0)
    plt.xlim(-600,600)
    plt.ylim(-600,600)
    plt.scatter(x,y)
    plt.plot(c_x,c_y)
    plt.show()


