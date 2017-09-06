
#!/usr/bin/env python

import matplotlib.pyplot as bplot
import numpy as np
import math # to explain/use the math functions

Nc = 10 ; dx = 1. / float( Nc )
x5 = [0. for i in range( Nc + 1 ) ] ; y5 = [0. for i in range( Nc + 1 ) ] ; y5b = [0. for i in range( Nc + 1 ) ] 
P5 = 1.5639 ; P7 = 0.1881

if True:

    for i in range(Nc + 1):
        if i > 0:
            x5[ i ] = x5[ i - 1 ] + dx
        y5[ i ] = x5[i] * P5 / ( x5[i] * P5 + (1. - x5[i] ) *P7 )

    y5b = x5

    bplot.title('')        #title of the plot
    bplot.plot(x5, y5,  'b-o', label= '')  
    bplot.plot(x5, y5b, 'r-', label= 'y=x')  
    bplot.grid(True)                                      #using this to display the grid
    bplot.xlabel('$x_{5}$')                                  #putting labels in x axis
    bplot.ylabel('$y_{5}$')                                     #putting labels in y axis

    bplot.legend(loc = 0)                                 #the location of the legend, 0:upper left corner ang going clockwise -> 1:upper right corner, 2:lower right corner, 3: lower left corner

    bplot.show()                                          #command that you put at the end of the plot to make it appear



x5 = [0. for i in range( Nc + 1 ) ] ; y5 = [0. for i in range( Nc + 1 ) ] 
P = [0. for i in range( Nc + 1 ) ] ; dP = (P5-P7) / float( Nc )

for i in range(Nc + 1):
    if i == 0:
        P[i] = P7
    else:
        P[ i ] = P[ i - 1 ] + dP

    x5[ i ] = ( P[i] - P7 ) / (P5 - P7 )
    y5[ i ] = x5[i] * P5 / P[i]
    print i, P[i], x5[i], y5[i]

bplot.title('')        #title of the plot
bplot.plot(x5, P,  'b-o', label= '$x_{5}$')  
bplot.plot(y5, P, 'r-x', label= '$y_{5}$')  
bplot.grid(True)                                      #using this to display the grid
bplot.xlabel('$x_{5},y_{5}$')                                  #putting labels in x axis
bplot.ylabel('P (bar)')                                     #putting labels in y axis

bplot.legend(loc = 0)                                 #the location of the legend, 0:upper left corner ang going clockwise -> 1:upper right corner, 2:lower right corner, 3: lower left corner

bplot.show()                                          #command that you put at the end of the plot to make it appear

