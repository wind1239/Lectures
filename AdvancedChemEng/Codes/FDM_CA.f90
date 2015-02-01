module functions_test

  implicit none

  integer, parameter :: nx = 5, n = 3, niter = 1, nt = 4
  !real, parameter :: x0 = 0., xf = 100., dt = 3., vel = 0.5 
  !real, parameter :: x0 = 0., xf = 40., dt = 0.2, vel = 0.5, w= 1.08
  real, parameter :: x0 = 0., xf = 60., dt = 0.50, vel = 0.50, w= 1.08

contains

  real function Utest( x )
    implicit none
    real :: x, Utemp

    if( .false. ) then
       Utemp = 0.0
       if ( ( x >= 20. ) .and. ( x <= 40. )) Utemp = 0.075 + exp( - 0.01 * ( x - 45. )**2 )
       Utest = Utemp

    else
       if( x <= 8. )then
          Utest = 0.40
       elseif( x >8. .and. x <= 35. )then
          Utest = 0.25
       else
          Utest = 0.
       end if

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


    if( .false. )then
  !if( .true. )then
     open(55, file = 'out.outt', status = 'unknown' )

     dx = ( xf - x0 ) / real( nx - 1 )
     allocate( x( nx + 1 ) );  x = 0. 
     allocate( uxnew( nx * ( nt + 1 ) + 1 ) ) ; uxnew( 0 : nx * ( nt + 1 ) ) = 0.
     allocate( uxtnew( nx * ( nt + 1 ) + 1 ) ) ; uxtnew( 0 : nx * ( nt + 1 ) ) = 0.
     allocate( uxold( nx * ( nt + 1 ) + 1 ) ) ; uxold( 0 : nx * ( nt + 1 ) ) = 0.

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
     write( 55, 300 ) ( uxtnew( ( j - 1 ) * nx + i ), i = 1, nx )
!stop 987
     Loop_Time: do j = 1, nt
print *, 'time', j
        Loop_Space: do i = 1, nx
print *, 'i', i
           uxtnew( j * nx + i ) = uxtnew( ( j - 1 ) * nx + i ) - alpha * &
                    ( uxtnew( ( j - 1 ) * nx + i + 1 ) - uxtnew( ( j - 1 ) * nx + i ) )
        end do Loop_Space
        uxtnew( j * nx + nx + 1 ) = uxtnew( j * nx + nx )
        print*, ( uxtnew( j * nx + i ), i = 1, nx )
        !write( 55, * ) ( uxtnew( j * nx + i ), i = 1, nx )
     end do Loop_Time

100 format( a3, 6x, 5(i2, 17x))
200 format( a2, 4x, 5(f6.2, 13x))
300 format( 5x, 5(f10.4, 8x))

!!$
!!$
!!$
!!$     loop_time: do j = 1, nt
!!$        loop_space: do i = 1, nx 
!!$           if ( j == 1 ) then
!!$              uxnew( ( j - 1 ) * nx + i ) = Utest( x( i ) ); uxnew( ( j - 1 ) * nx + i + 1 ) = Utest( x( i + 1 ) ) 
!!$           else
!!$              uxnew( ( j - 1 ) * nx + 1 : ( j - 1 ) * nx + nx ) = uxtnew( ( j - 2 ) * nx + 1 : ( j - 2 ) * nx + nx )
!!$           end if
!!$           uxtnew( ( j - 1 ) * nx + i ) = uxnew( ( j - 1 ) * nx + i ) - vel * ( dt / dx ) *  &
!!$                ( uxnew( ( j - 1 ) * nx + i + 1 ) - uxnew( ( j - 1 ) * nx + i ) )
!!$        end do loop_space

        !uxnew( ( j - 1 ) * nx + 1 : ( j - 1 ) * nx + nx ) = uxtnew( ( j - 1 ) * nx + 1 : ( j - 1 ) * nx + nx )
!!$
!!$        if( j == 1 )write( 55, * ) ( x( i ), i = 1, nx )
!!$        if( j == 1 )write( 55, * ) ( uxnew( ( j - 1 ) * nx + i ), i = 1, nx )
!!$        write( 55, * ) ( uxtnew( ( j - 1 ) * nx + i ), i = 1, nx )
!!$     end do loop_time
!!$     j = 1
!!$     write( 55, * ) ( x( i ), i = 1, nx )
!!$    ! write( 55, * ) ( uxnew( ( j - 1 ) * nx + i ), i = 1, nx )
!!$     write( 55, * ) ( uxtnew( ( j - 1 ) * nx + i ), i = 1, nx )



!!$     print*, ' i, x, uold_pre, xi+1, uold_pos, unew'
!!$     do j = 1, nt
!!$        do i = 1, nx
!!$           uold_pre = Utest( x( i ) ) ; uold_pos = Utest( x( i + 1 ) ) 
!!$           if ( i > 1 ) call CentralDiff( dx, uold_pre, uold_pos, unew )
!!$           print*, i, x( i ), uold_pre, x( i + 1 ), uold_pos, unew
!!$        end do
!!$     end do

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



end program test_fdm2
