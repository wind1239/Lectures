
#!/usr/bin/env python

import numpy as np
import math
import sys


def function1( x ):
    f = x**2 - 2.
    df = 2.*x
    return [f, df]

def Secant():
    k = 1
    while k <= Nmax:
        if k == 1:
            x1 = Guest1 ; x0 = Guest0
        F0, tempp0 = function1( x0 ) ; F1, tempp1 = function1( x1 )
        x2 = x1 - ( x1 - x0 ) / ( F1 - F0 ) * F1
        F2, tempp2 = function1( x2 )
        print 'Iteration ', k, 'with X=', x2, 'and F:', F2
        print '===>', abs( F2 ), abs( x2 - x1 )/abs( x1 )
        if k == Nmax:
            sys.exit( 'it did not converged' )
        else:
            if abs( F2 ) <= eps or abs( x2 - x1 )/abs( x1 ) <= eps:
                print 'X, F:', x2, F2
                print 'converged after', k, 'iterations'
                sys.exit()
            else:
                #print 'X0, X1, X2', x0, x1, x2
                #print 'F0, F1, F2', F0, F1, F2
                temp0 = x0 ; temp1 = x1 ; temp2 = x2
                x1 = temp2 ; x0 = temp1
        k+=1


def Newton():
    k = 1
    while k <= Nmax:
        if k == 1:
            x1 = Guest0#1#0
        F1, dF1 = function1( x1 )
        x2 = x1 - F1  / dF1
        F2, dF2 = function1( x2 )
        print 'Iteration ', k, 'with X=', x2, 'and F:', F2
        print '===>', abs( F2 ), abs( x2 - x1 )/abs( x1 )
        if k == Nmax:
            sys.exit( 'it did not converged' )
        else:
            if abs( F2 ) <= eps or abs( x2 - x1 )/abs( x1 ) <= eps:
                print 'X, F:', x2, F2
                print 'converged after', k, 'iterations'
                sys.exit()
            else:
                temp1 = x1 ; temp2 = x2 ; x1 = temp2 
        k+=1


''' MAIN '''
global Guest0, Guest1, Nmax, eps

Guest0 = 1.5 
Guest1 = 1.
Nmax = 10000
eps = 1.e-5

#Secant()
Newton()
