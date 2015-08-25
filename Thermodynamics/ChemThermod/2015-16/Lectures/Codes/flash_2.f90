module getall

contains

  real function activ( x )
    implicit none
    real :: x

    activ = exp ( 0.64 * ( 1 - x )**2 )

    return
  end function activ

  real function Psat( A, B, C, T )
    implicit none
    real :: A, B, C, T 

    Psat = exp( A - B /( T + C ) )

    return
  end function Psat


  real function dPsat( A, B, C, T )
    implicit none
    real :: A, B, C, T 

    dPsat = B * exp( A - B /( T + C ) ) / ( T + C )** 2

    return
  end function dPsat

end module getall


program flash2
  use getall
  implicit none
  real, parameter :: A1=14.3145, B1=2756.22, C1=228.06, A2=16.5785, B2=3638.27, C2=239.50
  real :: P, Told, Tnew, x, z, L, y
  integer :: i
  real :: Phi, dPhi

  P = 100. ! kPa = 1 bar
  x = 0.175

  Told = 100.
  do i = 1, 100

     Phi = P - ( x * activ( x ) * Psat( A1, B1, C1, Told ) + ( 1. - x ) * activ( 1. - x  ) * Psat( A2, B2, C2, Told ) )
     dPhi = - ( x * activ( x ) * dPsat( A1, B1, C1, Told ) + ( 1 - x ) * activ( 1. - x  ) * dPsat( A2, B2, C2, Told ) )
     Tnew = Told - Phi / dPhi
     print*,'iter, told, tnew:', i, told, tnew
     if( i > 1 ) then
        if( abs( tnew - told ) / told  <= 1.e-5 )then
           print*, 'final iter, told, tnew:', i, told, tnew
           exit
        else
           told = tnew
        end if
     else
        told = tnew
     end if
  end do

z = 0.25

L = ( z - x * activ( x ) * Psat( A1, B1, C1, Tnew ) / P ) / ( x - x * activ( x ) * Psat( A1, B1, C1, Tnew ) / P )
print *, 'L:', L

y = x * activ( x ) * Psat( A1, B1, C1, Tnew ) / P
print *, 'y:', y





end program flash2
