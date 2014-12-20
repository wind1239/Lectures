module auxiliary

  real, parameter :: tolerance = 1.e-4
  integer, parameter :: niter = 4, imeth = 1 ! = 1: Jacobi; = 2: GS; = 3: SOR

contains
  subroutine summall( n, i, a, xold, sum )
    implicit none
    integer, intent( in ) :: n, i
    real, dimension( n, n ), intent( in ) :: a
    real, dimension( n ), intent( in ) :: xold
    real, intent( inout ) :: sum
    integer :: j

    sum = 0.
    do j = 1, n
       if( j /= i ) then
          sum = sum + a( i, j ) * xold( j )
       endif
    end do

    return
  end subroutine summall

  subroutine Jacobi( n, a, b, xold, x )
    implicit none
    integer :: n
    real, dimension( n, n ), intent( in ) :: a
    real, dimension( n ), intent( in ) :: b, xold
    real, dimension( n ), intent( inout ) :: x
    ! Local variables
    integer :: i, j
    real :: sum 

    do i = 1, n
       sum = 0.
       do j = 1, n
          if( j /= i ) sum = sum + a( i, j ) * xold( j )
       end do
       x( i ) = ( b( i ) - sum ) / a( i, i )
    end do

    return
  end subroutine Jacobi


  subroutine GS_SOR( n, a, b, xold, w, x )
    implicit none
    integer :: n
    real, dimension( n, n ), intent( in ) :: a
    real, dimension( n ), intent( in ) :: b, xold
    real, intent( in ) :: w
    real, dimension( n ), intent( inout ) :: x
    ! Local variables
    integer :: i, j
    real :: sum1, sum2

    do i = 1, n
       sum1 = 0.
       do j = 1, i - 1
          sum1 = sum1 + a( i, j ) * x( j ) 
       end do
       sum2 = 0.
       do j = i + 1, n
          sum2 = sum2 + a( i, j ) * xold( j ) 
       end do
       x( i ) = ( 1. - w ) * xold( i ) + w * ( b( i ) - sum1 - sum2 ) / a( i, i )
    end do

!!$   write(55, * ) ( x( i ) , i = 1, n )

    return
  end subroutine GS_SOR



  subroutine convergence_criteria( n, a, b, x, conv )
    implicit none
    integer :: n
    real, dimension( n, n ), intent( in ) :: a
    real, dimension( n ), intent( in ) :: b, x
    logical, intent( inout ) :: conv
    ! Local
    real, dimension( : ), allocatable :: resmat
    integer :: i
    real :: sum

    allocate( resmat( n ) ); resmat = 0.

    resmat = matmul( a, x )

!!$    write(55,*)'resmat:', resmat

    sum = 0. ; conv = .true.
    do i = 1, n
       if( abs( b( i ) - resmat( i ) ) >  tolerance ) then
          conv = .false.
          exit
       endif
    end do

    deallocate( resmat )
    return
  end subroutine convergence_criteria

  real function norm( n, x, xold, diff )
    implicit none
    integer :: n
    real, dimension ( n ) :: x, xold
    logical :: diff
    ! local variables
    integer :: i
    real :: sum
    real, dimension( : ), allocatable :: xzero

    allocate( xzero( n ) ) ; xzero = 0.

    if( diff ) xzero = xold

    do i = 1, n
       sum = sum + ( x( i ) - xzero( i ) )**2
    end do
    norm = sqrt( sum )

    deallocate( xzero )

    return
  end function norm


  logical function TestDiagonalDominance( n, a )
    implicit none
    integer :: n
    real, dimension( n, n ) :: a
    real :: sum
    integer :: i, j
    logical :: diagonal_dominant_criteria, local_row

    diagonal_dominant_criteria = .true. 
    do i = 1, n
       sum = 0.
       do j = 1, n
          if ( j /= i ) then
             sum = sum + a( i , j )
          end if
       end do
       local_row = .false.
       if( abs( a( i, i )) > abs( sum ) ) local_row = .true.
       diagonal_dominant_criteria = diagonal_dominant_criteria .and. local_row         
    end do
    TestDiagonalDominance = diagonal_dominant_criteria

    return
  end function TestDiagonalDominance

end module auxiliary


program matrix_calc
  use auxiliary
  implicit none
!!$  integer, parameter :: n = 4
  integer :: n
  real, dimension( :, :), allocatable :: a
  real, dimension( : ), allocatable :: x, b, xold
  logical :: conv
  integer :: i, j, k, iter
  real :: sum, norma
  character( len = 20 ) :: method

  open( 5, file = 'matrices.in', status = 'unknown' )
  read( 5, * ) n

  allocate( a( n, n ) ); a = 0.
  allocate( b( n ) ); b = 0.
  allocate( x( n ) ); x = 0.
  allocate( xold( n ) ); xold = 0.
!!$
!!$  loop_i: do i = 1, n
!!$     loop_j: do j = 1, n
!!$        read( 5, * ) a( i, j )
!!$     end do loop_j
!!$  end do loop_i

  loop_i: do i = 1, n
     read( 5, * ) ( a( i, j ), j = 1, n )
  end do loop_i
  read( 5, * ) ( b( i ), i = 1, n )
  read( 5, * ) ( xold( i ), i = 1, n )
  close( 5 )


  a = 0.
  do i = 1, n
     do j = 1, n
        a( i, j ) = 1. / real( i + j -1 )
     end do
  end do

  open( 55, file = 'matrices.out', status = 'unknown' )
  write( 55, * )'b:', ( b( i ), i = 1, n ) 
  write( 55, * )'A:'
  loop_i2: do i = 1, n
     write( 55, * ) ( a( i, j ), j = 1, n )
  end do loop_i2
  if( .not. TestDiagonalDominance( n, a ) ) then
     write( 55, * )'A is not strictly diagonal dominant'
  else
     write( 55, * )'A is strictly diagonal dominant'
  end if

  Select case( imeth )
  case( 1 ); method = 'Jacobi'
  case( 2 ); method = 'Gauss-Seidel'
  case( 3 ); method = 'SOR'
  end Select
  write( 55, * )'Method: ', trim( method )

  ! Initial guess

  do iter = 1, niter

     select case( imeth )
     case( 1 ); ! Jacobi
        call Jacobi( n, a, b, xold, x )

     case( 2 ); ! Gauss-Seidl
        call GS_SOR( n, a, b, xold, 1., x )

     case( 3 ); ! SOR
        call GS_SOR( n, a, b, xold, 1.1, x )
     end select
     norma = norm( n, x, xold, .true. ) / norm( n, x, xold, .false. )

!!$     write( 55, * )'iter:', iter
!!$     write( 55, * ) 'xold:', ( xold( i ), i = 1, n )
!!$     write( 55, * ) 'x:', ( x( i ), i = 1, n )

     call convergence_criteria( n, a, b, x, conv )
     if( conv .or. ( norma <= tolerance ) ) then
        write( 55, * ) 'It converged after', iter, 'iterations!!'
        write( 55, * ) 'Solution vector:', ( x( i ), i = 1, n )
        write( 55, * ) 'Norm ratio:', norma
        return
     else
        if( iter == niter )then
           write( 55, * ) 'After', iter, 'iterations, the method did NOT converge'
           write( 55, * ) 'Last Solution:',  ( xold( i ), i = 1, n )
           write( 55, * ) 'Norm ratio:', norma
        else
           if( mod( iter, 10 ) == 0 ) then 
              write( 55, * ) 'iteration:', iter
              write( 55, * ) 'Norm ratio:', norma
              write( 55, * ) ' '
           endif
           xold = x
        end if
     end if

  end do
  close( 55 )

  deallocate( a )
  deallocate( b ) 
  deallocate( x )
  deallocate( xold )

end program matrix_calc
