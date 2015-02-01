module functions_test

  implicit none

  integer, parameter :: nx = 10, n = 3, niter = 1, nt = 30
  !real, parameter :: x0 = 0., xf = 100., dt = 3., vel = 0.5 
  !real, parameter :: x0 = 0., xf = 40., dt = 0.2, vel = 0.5, w= 1.08
  real, parameter :: x0 = 0., xf = 60., dt = 0.50, vel = 0.50, w= 1.08

contains

  real function Utest( x )
    implicit none
    real :: x, Utemp
    if( abs( x - 0.) <= 1.e-3 ) then
       Utest = 0.15
    elseif( x <= 3. )then
       Utest = 3.
    elseif( x > 3. .and. x <= 25. )then
       Utest = 10.
    else
       Utest = 10. / (1. + exp( 0.1 * ( x - xf ) ))
    end if

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


program test_fdm2
  use functions_test
  integer :: i, j, k
  real, dimension( : ), allocatable :: x, b, xold, xnew, uxnew, uxold, uxtnew
  real, dimension( : , : ), allocatable :: A
  real :: dx, unew, uold_pre, uold_pos, sum_1, sum_2, alpha

  open(55, file = 'out.outt', status = 'unknown' )

  dx = ( xf - x0 ) / real( nx - 1 )
  allocate( x( nx + 1 ) );  x = 0. 
  allocate( uxnew( nx * ( nt + 1 ) + 1 ) ) ;  uxnew( 1 : nx * ( nt + 1 ) ) = 0.
  allocate( uxtnew( nx * ( nt + 1 ) + 1 ) ) ; uxtnew( 1 : nx * ( nt + 1 ) ) = 0.
  allocate( uxold( nx * ( nt + 1 ) + 1 ) ) ;  uxold( 1 : nx * ( nt + 1 ) ) = 0.

  do i = 1, nx
     x( i ) = real( i - 1 ) * dx
  end do
  x( nx + 1 ) = x( nx )
  alpha = vel * ( dt / dx )

  j = 1
  do i = 1, nx
     uxtnew( ( j - 1 ) * nx + i ) = Utest( x( i ) )
  end do
  uxtnew( ( j - 1 ) * nx + nx + 1 ) = uxtnew( ( j - 1 ) * nx + nx )

  j = 1
  write( 55, 100 ) 'i/j', ( i, i = 1, nx )
  write( 55, 200 ) 'x:', ( x( i ), i = 1, nx )
  write( 55, * ) ( uxtnew( ( j - 1 ) * nx + i ), i = 1, nx + 1)
  !stop 987
  Loop_Time: do j = 1, nt
     write( 55, * ) j
     Loop_Space: do i = 1, nx
        if( i == 1 ) then 
           uxtnew( j * nx + i ) = Utest( x( i ) )
        else
           uxtnew( j * nx + i ) = uxtnew( ( j - 1 ) * nx + i ) - alpha * &
                ( uxtnew( ( j - 1 ) * nx + i + 1 ) - uxtnew( ( j - 1 ) * nx + i ) )
        end if
        write( 55, * ) uxtnew( j * nx + i )
     end do Loop_Space
     uxtnew( j * nx + nx + 1 ) = uxtnew( j * nx + nx )
     print*, j, ( uxtnew( j * nx + i ), i = 1, nx )
     !write( 55, * ) ( uxtnew( j * nx + i ), i = 1, nx )
  end do Loop_Time

100 format( a3, 6x, 5(i2, 17x))
200 format( a2, 4x, 5(f6.2, 13x))
300 format( 5x, 5(f10.4, 8x))

end program test_fdm2
