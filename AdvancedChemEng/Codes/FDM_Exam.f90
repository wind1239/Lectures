
module functions_test

  implicit none

  integer, parameter :: nx = 4, n = 3, niter = 1
  !real, parameter :: x0 = 0., xf = 100., dt = 3., vel = 0.5 
!!$  real, parameter :: x0 = 0., xf = 60., dt = 3., vel = 0.5, w= 1.08
  real, parameter :: x0 = 0., xf = 60., dt = 3., vel = 5., w= 1.08

contains

  real function Utest( x )
    implicit none
    real :: x, Utemp

    Utemp = 0.0
    if ( ( x >= 5. ) .and. ( x <= 40. )) Utemp = 7.5e-2 + exp( - 0.01 * ( x - 45. )**2 )
    Utest = Utemp

    return
  end function Utest


  subroutine CentralDiff( dx, U_pre, U_pos, U_new )
    implicit none
    real, intent( in ) :: dx, U_pre, U_pos
    real, intent(inout ) :: U_new

    U_new = U_pre - vel * dt / dx * ( U_pos - U_pre )

    return
  end subroutine CentralDiff

end module functions_test



program test_fdm
  use functions_test
  integer :: i, j, k
  real, dimension( : ), allocatable :: x, b, xold, xnew
  real, dimension( : , : ), allocatable :: A
  real :: dx, unew, uold_pre, uold_pos, sum_1, sum_2


  if( .false. )then
     dx = ( xf - x0 ) / real( nx - 1 )
     allocate( x( nx + 1 ) );  x = 0. 
     do i = 1, nx
        x( i ) = real( i - 1 ) * dx
     end do
     x( nx + 1 ) = x( nx )


     print*, ' i, x, uold_pre, xi+1, uold_pos, unew'
     do i = 1, nx
        uold_pre = Utest( x( i ) ) ; uold_pos = Utest( x( i + 1 ) ) 
        if ( i > 1 ) call CentralDiff( dx, uold_pre, uold_pos, unew )
        print*, i, x( i ), uold_pre, x( i + 1 ), uold_pos, unew

     end do

  else

   allocate( A( n, n ) ); A = 0.
   allocate( b( n ) ) ; b = 0.
   allocate( xold( n ) ) ; xold = 0.
   allocate( xnew( n ) ) ; xnew = 0.

   A(1,1) = 3. ; A(1,2) = 1. ; A(1,3) = 1. ; A(2,1) = 1. ; A(2,2) = 2. ; A(2,3) = 0. ; A(3,1) = 1. ; A(3,2) = .5 ; A(3,3) = 2. ; 
   b(1) = 4.5 ; b(2) = 2. ; b(3) = 2.45 
   
   xold = 1. ; xnew = xold
   
   do k = 1, niter

      do i = 1, n

        sum_1 = 0.
        do j = 1, i - 1, 1
           sum_1 = sum_1 + A( i, j ) / A( i, i ) * xnew( j )    
        end do
        sum_2 = 0.
        do j = i+1, n
           sum_2 = sum_2 + A( i, j ) / A( i, i ) * xold( j )    
        end do

        xnew( i ) = ( 1 - w ) * xold( i ) + w * ( b( i ) / a( i, i ) - sum_1 - sum_2 )
   
        print*, 'iter, i, xnew:', k, i, xnew(i)

      end do

      xold = xnew

   end do


  end if



end program test_fdm
