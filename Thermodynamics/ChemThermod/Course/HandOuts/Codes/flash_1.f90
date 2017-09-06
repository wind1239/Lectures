
real function fct( pi, alpha, beta, gamma, T )
  implicit none
    real :: pi, alpha, beta, gamma, T

    fct = pi * T**3 + alpha * T**2 + beta * T + gamma

  return
end function fct

real function dfct( pi, alpha, beta, T )
  implicit none
    real :: pi, alpha, beta, T

    dfct = 3. * pi * T**2 + 2. * alpha * T + beta 

  return
end function dfct

program flash
  implicit none
  real :: a, b, c, d, e, f, k1, k2, k3, pi, alpha, beta, gamma, func, dfunc
  real :: told, tnew, x5, x6, x7
  real :: fct, dfct
  integer :: i


  k1 = 2.6861 ; k2 = 1.0109 ; k3 = .3840
  a = 1. - k1 ; b = k1 ; c = 1. - k2 ; d = k2 ; e = 1. - k3 ; f = k3

  alpha = (a * d * e) + (b * c * e) + (a * c * f) - ( 0.25 * (c * e) + 0.45 * (a * e) + 0.30 * (a * c) )
  beta = (b * d * e ) + (a * d * f) + (b * c * f) - ( 0.25 * (c * f + d * e) + 0.45 * (a * f + b * e) + 0.3 * (a * d + b * c) )
  gamma = (b * d * f) - ( 0.25 * (d * f) + 0.45 * (b * f) + 0.3 * (b * d) )
  pi = (a * c * e)

  !print*, 'pi, alpha, beta, gamma:', pi, alpha, beta, gamma

  told = 0.5
  do i = 1, 1000
     tnew = told - fct( pi, alpha, beta, gamma, Told ) / dfct( pi, alpha, beta, Told )
     print*,'iter, told, tnew:', i, told, tnew
     if( i > 1 ) then
        if( tnew <= 1. .and. tnew >= 0. .and. abs( tnew - told ) / told  <= 1.e-5 )then
           print*, 'final iter, told, tnew:', i, told, tnew
           exit
        else
          told = tnew
        end if
     else
        told = tnew
     end if
  end do

  x5 = 0.25 / ( a * tnew + b ) ; x6 = 0.45 / ( c * tnew + d ) ; x7 = 0.3 / ( e * tnew + f )
  print*, x5, x6, x7, x5 + x6 + x7
  





end program flash
