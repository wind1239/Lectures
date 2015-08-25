module VaporPressure

contains

  real function Antoine_Psat( A, B, C, T )
    implicit none
    real :: A, B, C, T
    real :: Psat2

    Psat2 = A - B / ( T + C )
    Antoine_Psat = exp( Psat2 )

  end function Antoine_Psat

  real function Psat( A, B, T )
    implicit none
    real,parameter :: R = 8.314
    real :: A, B, T

    Psat = A - B / (R*T)
    Psat = exp( Psat )

  end function Psat

  real function dPsat( A, B, T )
    implicit none
    real,parameter :: R = 8.314
    real :: A, B, T

    dPsat = A - B / (R*T)
    dPsat = B * exp( dPsat ) / ( R * T**2 )

  end function dPsat
  
  real function dPsat2( A, B, T ) !Psat in the denominator
    implicit none
    real,parameter :: R = 8.314
    real :: A, B, T

    dPsat2 = A - B / (R*T)
    dPsat2 = -B * exp( -dPsat2 ) / ( R * T**2 )

  end function dPsat2
  

end module VaporPressure

program vle1
  use VaporPressure
  implicit none
  integer, parameter :: n = 10, ncomp = 3
  real, dimension( n + 1 ) :: x, y, x1, y1, x2, y2, x3, y3
  real, dimension( ncomp ) :: A, B, C, Pvap, dPvap
  real :: T, P, F, dF, Told, Tnew, Pold, Pnew
  integer :: i, j

  open( 55, file = 'out.out', status = 'unknown' )
  open( 56, file = 'out2.out', status = 'unknown' )

  T = 50. + 273.15
  A(1) = 10.422 ; B(1) = 26799. ; A(2) = 11.431 ; B(2) = 35200. ; A(3) = 10.456 ; B(3) = 29676. ; 



  if( .false. ) then
     Pvap( 1 ) = Psat( A(1), B(1), T ) ; dPvap( 1 ) = dPsat( A(1), B(1), T )
     Pvap( 2 ) = Psat( A(2), B(2), T ) ; dPvap( 2 ) = dPsat( A(2), B(2), T )

     ! Problem 1, Part 1a
     do i = 1, n + 1
        x( i ) = real( i - 1 ) / real ( n )
        y( i ) = x( i ) * Pvap( 1 ) / ( x( i ) * Pvap( 1 ) + ( 1 - x( i ) ) * Pvap( 2 ) )
        !write( 55, * ) x( i ), y( i )
     end do


     ! Problem 1, Part 1b
     P = 0.1
     do i = 1, n + 1
        P = P + 0.1
        x( i ) = ( P - Pvap( 2 ) ) / ( Pvap( 1 ) - Pvap( 2 ) )
        y( i ) = x( i ) * Pvap( 1 ) / P
        if( x( i ) < 0. .or. x( i ) > 1 .or. y( i ) < 0. .or. y( i ) > 1. ) exit
        !write( 55, * ) x( i ), P
        !write( 56, * ) y( i ), P
     end do

     ! Problem 1, Part 1b
     do i = 1, n + 1
        x( i ) = real( i - 1 ) / real ( n )
        Told = 310.
        do j = 1, 100
           T = Told
           Pvap( 1 ) = Psat( A(1), B(1), T ) ; dPvap( 1 ) = dPsat( A(1), B(1), T )
           Pvap( 2 ) = Psat( A(2), B(2), T ) ; dPvap( 2 ) = dPsat( A(2), B(2), T )

           F = x( i ) * Pvap( 1 ) + ( 1 - x( i ) ) * Pvap( 2 ) - 1.013
           dF = x( i ) *  dPvap( 1 ) + dPvap( 2 ) - x( i ) *  dPvap( 2 )
           Tnew = Told - F / dF

           if( abs( ( Tnew - Told ) / Told ) <= 1.e-3 ) then 
              y( i ) = x( i ) * Pvap( 1 ) / ( x( i ) * Pvap( 1 ) + ( 1 - x( i ) ) * Pvap( 2 ) )
              ! write(55, * ) Tnew, x( i ), y( i ) 
              exit
           else 
              Told = Tnew
           end if
        end do
     end do

     ! Problem 2, Part 1a
!!$
     x1( 1 ) = 0.25 ; x2( 1 ) = 0.3 ; x3( 1 ) = 0.45 ! nC5, nC7 and nC6 
     P = 1.013
     Told = 298.15
     do j = 1, 100
        T = Told
        Pvap( 1 ) = Psat( A(1), B(1), T ) ; dPvap( 1 ) = dPsat( A(1), B(1), T )
        Pvap( 2 ) = Psat( A(2), B(2), T ) ; dPvap( 2 ) = dPsat( A(2), B(2), T )
        Pvap( 3 ) = Psat( A(3), B(3), T ) ; dPvap( 3 ) = dPsat( A(3), B(3), T )

        F = ( x1( 1 ) * Pvap( 1 ) + x2( 1 ) * Pvap( 2 ) + x3( 1 ) * Pvap(3 ) ) / P - 1.
        dF = ( x1( 1 ) * dPvap( 1 ) + x2( 1 ) * dPvap( 2 ) + x3( 1 ) * dPvap( 3 ) ) / P

        Tnew = Told - F / dF
        !write(55,*)'old/new:', told,tnew

        if( abs( ( Tnew - Told ) / Told ) <= 1.e-5 ) then 
           y1( 1 ) = x1( 1 ) * Pvap( 1 ) / P ; y2( 1 ) = x2( 1 ) * Pvap( 2 ) / P ; y3( 1 ) = x3( 1 ) * Pvap( 3 ) / P ; 
           if( abs( 1. - ( y1( 1 ) + y2( 1 ) + y3( 1 ) )) < 1.e-3 )then 
              !write(55, * ) Tnew, y1( 1 ), y2( 1 ), y3( 1 ), y1( 1 ) + y2( 1 ) + y3( 1 ) 
              exit
           endif
           Told = Tnew
        else 
           Told = Tnew
        end if
     end do


     ! Problem 2, Part 1b
!!$
     y1( 1 ) = 0.25 ; y2( 1 ) = 0.3 ; y3( 1 ) = 0.45 ! nC5, nC7 and nC6 
     P = 1.013
     Told = 300.
     do j = 1, 100
        T = Told
        Pvap( 1 ) = Psat( A(1), B(1), T ) ; dPvap( 1 ) = dPsat2( A(1), B(1), T )
        Pvap( 2 ) = Psat( A(2), B(2), T ) ; dPvap( 2 ) = dPsat2( A(2), B(2), T )
        Pvap( 3 ) = Psat( A(3), B(3), T ) ; dPvap( 3 ) = dPsat2( A(3), B(3), T )

        F = P * ( y1( 1 ) / Pvap( 1 ) + y2( 1 ) / Pvap( 2 ) +  y3( 1 ) / Pvap( 3 ) ) - 1.
        dF = P * ( y1( 1 ) * dPvap( 1 ) + y2( 1 ) * dPvap( 2 ) + y3( 1 ) * dPvap( 3 ) )

        ! write(55,*)'f,df:',F, df
        Tnew = Told - F / dF
        write(55,*)'old/new:', told,tnew

        !stop 876
        if( abs( ( Tnew - Told ) / Told ) <= 1.e-5 ) then 
           x1( 1 ) = y1( 1 ) * P / Pvap( 1 ) ; x2( 1 ) = y2( 1 ) * P / Pvap( 2 ) ; x3( 1 ) = y3( 1 ) * P / Pvap( 3 ) ; 
           !write(55,*)'close?:',  x1( 1 ) + x2( 1 ) + x3( 1 )
           if( abs( 1. - ( x1( 1 ) + x2( 1 ) + x3( 1 ) )) < 1.e-3 )then 
              write(55, * ) Tnew, x1( 1 ), x2( 1 ), x3( 1 ), x1( 1 ) + x2( 1 ) + x3( 1 ) 
              exit
           endif
           Told = Tnew
        else 
           Told = Tnew
        end if
     end do

  end if



  ! Problem 2, Part 1b
!!$
  y1( 1 ) = 0.25 ; y2( 1 ) = 0.3 ; y3( 1 ) = 0.45 ! nC5, nC7 and nC6 
  T = 73. + 273.15
  Pvap( 1 ) = Psat( A(1), B(1), T ) ; dPvap( 1 ) = dPsat2( A(1), B(1), T )
  Pvap( 2 ) = Psat( A(2), B(2), T ) ; dPvap( 2 ) = dPsat2( A(2), B(2), T )
  Pvap( 3 ) = Psat( A(3), B(3), T ) ; dPvap( 3 ) = dPsat2( A(3), B(3), T )
  Pold = 1.013

  do j = 1, 100
     P = Pold

     F = P * ( y1( 1 ) / Pvap( 1 ) + y2( 1 ) / Pvap( 2 ) + y3( 1 ) / Pvap( 3 ) ) - 1.
     dF = y1( 1 ) / Pvap( 1 ) + y2( 1 ) / Pvap( 2 ) + y3( 1 ) / Pvap( 3 )

     Pnew = Pold - F / dF
        write(55,*)'old/new:', pold,pnew

     if( abs( ( Pnew - Pold ) / Pold ) <= 1.e-5 ) then 
        x1( 1 ) = y1( 1 ) * P / Pvap( 1 ) ; x2( 1 ) = y2( 1 ) * P / Pvap( 2 ) ; x3( 1 ) = y3( 1 ) * P / Pvap( 3 ) ; 
        if( abs( 1. - ( x1( 1 ) + x2( 1 ) + x3( 1 ) )) < 1.e-3 )then 
           write(55, * ) Pnew, x1( 1 ), x2( 1 ), x3( 1 ), x1( 1 ) + x2( 1 ) + x3( 1 ) 
           exit
        endif
        pold = pnew
     else 
        pold = pnew
     end if
  end do


  return
end program vle1
