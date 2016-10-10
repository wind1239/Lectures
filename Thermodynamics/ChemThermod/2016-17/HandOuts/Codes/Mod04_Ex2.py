
#!/usr/bin/env python

import matplotlib.pyplot as bplot
import numpy as np
import math # to explain/use the math functions


Nc = 10 ; dx = 1. / float( Nc )
x5 = [0. for i in range( Nc + 1 ) ] ; y5 = [0. for i in range( Nc + 1 ) ] ; T = [0. for i in range( Nc + 1 ) ]  ; y5b = [0. for i in range( Nc + 1 ) ] 

for i in range( Nc + 1 ):
    if i> 0:
        x5[ i ] = x5[ i - 1 ] + dx


y5b = x5

y5[0] = 0.0; y5[1] = 0.4050; y5[2] = 0.6249; y5[3] = 0.7535; y5[4] = 0.8345; y5[5] = 0.8881; y5[6] = 0.9257; y5[7] = 0.9528; y5[8] = 0.9728; y5[9] = 0.9881; y5[10] = 1.
T[0] = 370.90; T[1] = 357.80; T[2] = 347.73; T[3] = 339.73; T[4] = 333.21; T[5] = 327.77; T[6] = 323.13; T[7] = 319.12; T[8] = 315.60; T[9] = 312.47; T[10] = 309.67
 
bplot.title('')        #title of the plot
bplot.plot(x5, y5,  'b-o', label= '')  
bplot.plot(x5, y5b, 'r-', label= 'y=x')  
bplot.grid(True)                                      #using this to display the grid
bplot.xlabel('$x_{5}$')                                  #putting labels in x axis
bplot.ylabel('$y_{5}$')                                     #putting labels in y axis

bplot.legend(loc = 0)                                 #the location of the legend, 0:upper left corner ang going clockwise -> 1:upper right corner, 2:lower right corner, 3: lower left corner

bplot.show()                                          #command that you put at the end of the plot to make it appear


bplot.title('')        #title of the plot
bplot.plot(x5, T,  'b-o', label= '$x_{5}$')  
bplot.plot(y5, T, 'r-x', label= '$y_{5}$')  
bplot.grid(True)                                      #using this to display the grid
bplot.xlabel('$x_{5},y_{5}$')                                  #putting labels in x axis
bplot.ylabel('T (K)')                                     #putting labels in y axis

bplot.legend(loc = 0)                                 #the location of the legend, 0:upper left corner ang going clockwise -> 1:upper right corner, 2:lower right corner, 3: lower left corner

bplot.show()                                          #command that you put at the end of the plot to make it appear

