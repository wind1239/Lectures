#!/usr/bin/env python

import BlackboardQuiz

with BlackboardQuiz.Package("MyBlackboardPackage") as package:
    with package.createPool('Transient Heat Transfer and Introduction to Heat Exchangers') as pool:
        # Question 1:
        pool.addQuestion('Analytical solutions for differential problems are based on',
                         ['Driving the governing differential equation by performing an energy balance on a differential volume element;',
                          'Expressing the boundary conditions in the proper mathematical form;',
                          'Solving the differential equation and applying the boundary conditions to determine the integration constants;',
                          'All the options above.'],
                         correct=4)

        # Question 2:
        pool.addQuestion('Numerical methods are based on:',
                         ['Solving partial differential equations using trigonometric-based methods;',
                          'Solving ordinary differential equations using log-based methods;',
                          'Replacing differential equations by algebraic equations;',
                          'None of the options above.'],
                         correct=3)

        # Question 3:
        pool.addQuestion('A long aluminium cylinder 50 mm in diameter ($$\kappa=$$ 215 W/(m.K), $$\rho=$$ 2700 kg/m$$^{3}$$, $$C_{p}=$$ 0.9 kJ/(kg.K), and $$\alpha=$$ 8.4$\times$ 10$$^{-5}$$ m$$^{2}$$/s) and initially at 473.15 K is suddenly exposed to a convective environment at 343.15 K and h = 525 W/(m$$^{2}$$.K). Calculate the temperature at a radius of 12.5 mm and the heat lost 1 min after the cylinder is exposed to the environment.',
                         ['393.32 K, 383.05 kJ;',
                          '393.32 K, 310.12 kJ;',
                          '385.58 K, 620.27 kJ;',
                          'None of the options above.'],
                         correct=1)

        # Question 4:
        pool.addQuestion('In a fire-tube boiler, hot products of combustion flowing through an array of thin-walled tubes are used to boil water flowing over the tubes. At the time of installation, the overall heat transfer coefficient was 400 W/(m$^{2}$.K). After 1 year of use, the inner and outer tube surfaces are fouled, with fouling factors of 0.0015 and 0.0005 m$^{2}$.K/W, respectively. What is the overall heat transfer coefficient after one year of use? Should the boiler be scheduled for cleaning? Assume that the tube surfaces need to be cleaned when the overall heat coefficient is reduced to 60$\%$ of the initial value.',
                         ['111.11 W/(m$^{2}$.K); Yes;',
                          '237.45 W/(m$^{2}$.K); Yes;',
                          '351.23 W/(m$^{2}$.K); No;',
                          '222.22 W/(m$^{2}$.K); Yes;'],
                         correct=4)

        # Question 5:
        pool.addQuestion('A steel pipeline (AISI 1010) has diameter of 1 m and wall thickness of 40 mm. The pipe is heavily insulated on the outside, and, before the initiation of flow, the walls of the pipe are at a uniform temperature of -20$^{\circ}$C. With the initiation of flow, hot oil at 60$^{\circ}$C is pumped through the pipe, creating a convective condition corresponding to $h=$ 500 W/(m$^{2}$.K) at the inner surface of the pipe. (i) What is the Fourier number 8 min after the initiation of the flow? (ii) At $t=$ 8 min, what is the temperature of the exterior pipe surface covered by the insulation? (iii) What is the heat flux to the pipe from the oil at $t=$ 8 min? For steel AISI 1010, assume $\rho=$ 7832 kg/m$^{3}$, $C_{p}=$ 434 J/(kg.K), $\kappa=$ 63.9 W/(m.K) and $\alpha=$ 18.8$\times$10$^{-6}$ m$^{2}$/s.',
                         ['(i) 5.640; (ii) 313.05 K;      (iii)  7400 W/m$^{2}$;',
                          '(i) 0.313; (ii) 313.05 K;      (iii) -6050 W/m$^{2}$;',
                          '(i) 5.640; (ii) 42.9$^{\circ}$C; (iii) -7400 W/m$^{2}$;',
                          '(i) 0.094; (ii) 45.2$^{\circ}$C; (iii)  6050 W/m$^{2}$;'],
                         correct=3)

        # Question 6:
        pool.addQuestion('A fuel element of a pressurised water nuclear reactor (PWR) is in the shape of a plane wall of thickness of 10 mm and is convectively cooled at both surfaces, with $h=$ 1100 W/(m$^{2}$.K) and T$_{\infty}=$ 250$^{\circ}$C. At normal operating power, heat is generated uniformly within the element leading to a temperature profile $T_{\text{initial}}$. A departure from the steady-state conditions associated with normal operation occurs with the imposed volumetric generation rate of 20 MW/m$^{3}$. Calculate the temperature distribution at $t=$ 0.6 s, $T\left(\underline{x},t=0.6\;s\right)$, using the finite difference method with $\Delta t=$ 0.3 s. Assume $\Delta x=$ 2 mm with $T_{\text{initial}}=\left[357.58,\; 356.91,\; 354.91,\; 351.58,\; 346.91,\; 340.91\right]^{\circ}$C. The fuel element thermal properties are $\kappa=$ 30 W/(m.K) and $\alpha=$ 5$\times$10$^{-6}$ m$^{2}$/s.',
                         ['$T\left(\underline{x},t=0.6\;s\right)= \left[ 358.58,\; 357.91,\; 355.91,\; 352.58,\; 347.91,\; 341.88\right]^{\circ}$C;',
                          '$T\left(\underline{x},t=0.6\;s\right)= \left[ 358.08,\; 357.41,\; 355.41,\; 352.08,\; 347.41,\; 341.41\right]^{\circ}$C;',
                          '$T\left(\underline{x},t=0.6\;s\right)= \left[ 358.50,\; 357.51,\; 357.78,\; 355.21,\; 347.91,\; 341.41\right]^{\circ}$C;',
                          '$T\left(\underline{x},t=0.6\;s\right)= \left[ 355.50,\; 354.98,\; 350.19,\; 345.22,\; 340.98,\; 331.76\right]^{\circ}$C.'],
                         correct=1)

        # Question 7:
        pool.addQuestion('The condenser of a steam power plant contains $N=$ 1000 brass tubes ($\kappa=$ 110 W/(m.K)), each of inner and outer diameters, $D_{i}=$ 25 mm and $D_{o}=$ 28 mm, respectively. Steam condensation on the outer surfaces of the tubes is characterized by a convection coefficient of $h_{o}=$ 10 kW/(m$^{2}$.K). If cooling water from a lake is pumped through the condenser tubes at $\dot{m}_{c}=$ 400 kg/s, what is the overall heat transfer coefficient $U_{o}$ based on the outer surface rea of a tube?  Given: $h_{i}=$ 3400 W/(m$^{2}$.K).',
                         ['2500.45 W/(m$^{2}$.K);',
                          '1503.45 W/(m$^{2}$.K);',
                          '2253.09 W/(m$^{2}$.K);',
                          '2255.00 W/(m$^{2}$.K).'],
                         correct=3)

        # Question 8:
        pool.addQuestion('Under what conditions is the thermal resistance of the tube in a heat exchanger negligible?',
                         ['When the wall thickness of the tube is large and the thermal conductivity of the tube material is high;',
                          'When the wall thickness of the tube is small and the thermal conductivity of the tube material is high;',
                          'When the wall thickness of the tube is small and the thermal conductivity of the tube material is small;',
                          'None of the options above.'],
                         correct=2)

        # Question 9:
        pool.addQuestion('Under what conditions will the temperature rise of the cold fluid in a heat exchanger be equal to the temperature drop of the hot fluid?',
                         ['When the heat capacity rate of the cold fluid is slightly larger than the heat capacity rate of the hot fluid;',
                          'When the heat capacity rate of the cold fluid is substantially larger than the heat capacity rate of the hot fluid;',
                          'When the heat capacity rate of the cold fluid is smaller than the heat capacity rate of the hot fluid;',
                          'When the heat capacity rates of the cold and hot fluids are identical.'],
                         correct=4)

        # Question 10:
        pool.addQuestion('Consider a sphere and a cylinder of equal volume made of steel. Both solids are initially at the same temperature and are exposed to convection in the same environment. Which solid will cool faster? Why?',
                         ['The cylinder will cool faster than the sphere since heat transfer rate is proportional to the surface area, and the sphere has the smallest area for a given volume;',
                          'The sphere will cool faster than the cylinder since heat transfer rate is proportional to the surface area, and the cylinder has the smallest area for a given volume;',
                          'Both solids will cool at the same rate as they are exposed to the same heat transfer mechanisms;',
                          'The cylinder will cool faster than the sphere since heat transfer rate is proportional to the surface area, and the sphere has the larges area for a given volume;'],
                         correct=1)

        
        
