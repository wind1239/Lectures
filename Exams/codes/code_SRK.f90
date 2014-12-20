real function FF( z, beta, qq )
  implicit none
  real :: z, beta, qq, aux

  aux = z**2 + beta * z
   
  FF = z - ( 1. + beta - qq * beta * ( z - beta ) / aux )

!beta + qq * beta * z / (z**2 + beta * z) - qq * beta**2 / (z**2 + beta * z )
   
  return
end function FF

real function DFF( z, beta, qq )
  implicit none
  real :: z, beta, qq, aux

  aux = z**2 + beta * z

  DFF = 1. + qq * beta * ( 1./ aux + ( z - beta ) * ( 2. * z + beta ) / aux**2 )

  !DFF = 1 + (qq * aux - qq * beta * z * (2. * z + beta)) / aux**2 + qq * beta**2 * (2. * z + beta )/ aux**2  

  return
end function DFF

program srkcode
  implicit none
  real :: qq, beta
  real :: zold, znew, z0
  integer :: i, niter
  real :: eps, tol
  real :: FF, DFF

  print*, 'Root-finder subroutine for the following function:'
  print*, 'F(Z) = Z - Beta + Q * Beta * Z / ( Z^2 + Beta * Z ) - Q * Beta^2 / ( Z^2 + Beta * Z )'

  qq = 6.7274 ; beta = 3.88e-2 ; niter = 100; tol = 1.e-5
  !qq = 6.727 ; beta = 3.8877e-2 ; niter = 1000; tol = 1.e-5

  zold = 0.7217
  do i = 1, niter
    znew = zold - FF( zold, beta, qq ) / DFF(zold,beta, qq )
     print*, 'iter:', i, zold, znew
    if ( i >= 2) then
      eps =  abs( zold - znew ) 
      if ( eps <= tol )then
         print *, 'final znew:', znew
         stop 55
      end if
    end if
    zold = znew

  end do

  


end program srkcode
