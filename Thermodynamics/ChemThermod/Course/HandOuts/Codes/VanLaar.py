
#!/usr/bin/env python

import matplotlib.pyplot as bplot
import numpy as np
import math # to explain/use the math functions

B12 = 1.15; B21=.92; A21=B21; A12=B12
P1s = 0.9453; P2s = 0.8613
x = np.arange(0., 1.01, 0.01)
n=len(x)
y1=[0. for i in range( n) ]
P=[0. for i in range( n) ]

for i in range(n):
    x1 = x[i] ; x2 = 1. - x1
    P1 = x1 * math.exp( B12 * ( 1. + B12 * x1 / ( A21 * max(1.e-7,x2) ) )**-2)*P1s
    #print x1, x2, B21, P2s
    P2 = x2 * math.exp( B21 * ( 1. + B21 * x2 / ( A12 * max(1.e-22,x1) ) )**-2)*P2s
    #print x1, P1,P2
    P[i]= P1 + P2
    y1[i] = x1*math.exp(B12*(1+B12*x1/(A21*max(1.e-7,x2)))**-2)*P1s/P[i]
    print x1, P[i], y1[i]
    


bplot.title('P-x-y Diagram at 75$^{\circ}$C')        #title of the plot
bplot.plot(x, P,  'b-', label= 'liq')  
bplot.plot(y1, P, 'r-', label= 'vap')  
#bplot.plot(x5, y5b, 'r-', label= 'y=x')  
bplot.grid(True)                                      #using this to display the grid
bplot.xlabel('$x_{1}/y_{1}$')                                  #putting labels in x axis
bplot.ylabel('$P$')                                     #putting labels in y axis

bplot.legend(loc = 0)                                 #the location of the legend, 0:upper left corner ang going clockwise -> 1:upper right corner, 2:lower right corner, 3: lower left corner

bplot.show()
#command that you put at the end of the plot to make it appear

bplot.title('x-y Diagram at 75$^{\circ}$C')        #title of the plot
bplot.plot(x, y1,  'b-', label= '')  
bplot.plot(x, x, '--', label= 'y=x')  
bplot.grid(True)                                      #using this to display the grid
bplot.xlabel('$x_{1}$')                                  #putting labels in x axis
bplot.ylabel('$y_{1}$')                                     #putting labels in y axis

bplot.legend(loc = 0)                                 #the location of the legend, 0:upper left corner ang going clockwise -> 1:upper right corner, 2:lower right corner, 3: lower left corner

bplot.show()                                          #command that you put at the end of the plot to make it appear
