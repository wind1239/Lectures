#!/usr/bin/python

import numpy as np
import matplotlib.pyplot as plt
import math
from scipy.optimize import fsolve


def set_Global_Variables():
    global ncomp, PSat_A, PSat_B, PSat_C, Cij
    ncomp = 2
    PSat_A = [0. for i in range( ncomp ) ]
    PSat_B = [0. for i in range( ncomp ) ]
    PSat_C = [0. for i in range( ncomp ) ]
    
    PSat_A[0] = 14.71712 ; PSat_B[0] = 2975.95 ; PSat_C[0] = 34.5228
    PSat_A[1] = 16.5362  ; PSat_B[1] = 3985.44 ; PSat_C[1] = 38.9974

    Cij = np.matrix( [ [0.1173, 0.], [0., 0.4227] ] )

    #Cij = [ [0. for i in range( ncomp ) ] for j in range( ncomp )]
    #Cij[0,1] = 0.1173 ; C[1,0] = 0.4227


def PSAT_Calc( icomp, Temp ): # Defining Antonine equation with P in kPa and T in K
    set_Global_Variables()

    P_Sat = math.exp( PSat_A[ icomp ] - PSat_B[ icomp ] / ( Temp - PSat_C[ icomp ] ))
    return P_Sat

def WilsonModel_Activity( icomp, jcomp, Comp ): # Defining the wilson model for activity
    set_Global_Variables()
    X1 = Comp[ icomp ] ; X2 = 1. - X1

    G = - math.log( X1 + X2 * Cij[ icomp, jcomp ] ) + X2 * ( Cij[ icomp, jcomp ] / ( X1 + X2 * Cij[ icomp, jcomp ] ) - Cij[ jcomp, icomp ] / ( X2 + X1* Cij[ jcomp, icomp ] ) )
    Gamma = math.exp( G )
    return Gamma




set_Global_Variables()
icomp = 0; nmax = 1; P = 101.3

CompV = [0. for i in range( ncomp ) ] ; CompL = [0. for i in range( ncomp ) ] 
CompV[ 0 ] = 0.40 ; CompV[ 1 ] = 1. - CompV[ 0 ]
Gamma = [ 0. for i in range( ncomp ) ]

for iter in range( nmax ):
    if iter == 1:
        CompL[ 0 ] = 0.01 ; CompL[ 1 ] = 1. - CompL[ 0 ]

    icomp = 0 ; Gamma[ icomp ] = WilsonModel_Activity( icomp, icomp + 1, CompL )
    icomp = 1 ; Gamma[ icomp ] = WilsonModel_Activity( icomp, icomp - 1, CompL )
    print 'Gamma:', Gamma[0], Gamma[1]

    func = lambda Temp : CompV[ 0 ] * P / ( Gamma[ 0 ] * PSAT_Calc( 0, Temp ) ) + CompV[ 1 ] * P / ( Gamma[ 1 ] * PSAT_Calc( 1, Temp ) ) - 1.

    T = fsolve( func, 300. )
    print 'T:', T
        





"""


# Define the expression whose roots we want to find

a = 0.5
R = 1.6

func = lambda tau : R - ((1.0 - np.exp(-tau))/(1.0 - np.exp(-a*tau))) 

# Plot it

tau = np.linspace(-0.5, 1.5, 201)

plt.plot(tau, func(tau))
plt.xlabel("tau")
plt.ylabel("expression value")
plt.grid()
plt.show()

# Use the numerical solver to find the roots

tau_initial_guess = 0.5
tau_solution = fsolve(func, tau_initial_guess)

print "The solution is tau = %f" % tau_solution
print "at which the value of the expression is %f" % func(tau_solution)
"""
