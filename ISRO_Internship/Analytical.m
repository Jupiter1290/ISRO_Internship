close all;
clear;
clc;
%Modelling the nozzle:
r_1=0.0045; r_t=0.00205; r_2=0.006;
l_con=0.00327;l_div=0.015;
A_t=pi*r_t^2; gamma=1.4;
%Defining the domain
l_domain=0.950;
x_con=linspace(0,l_con,100);
x_div=linspace(l_con,l_div+l_con,500);
x_jet=linspace(l_div+l_con,l_domain,5000);
%Converging section modelling
slope_con=(r_t-r_1)/l_con;
R_con=@(x)  slope_con*x+r_1;
A_con=@(x) pi*(R_con(x))^2;
%Divergining Section modelling
slope_div=(r_2-r_t)/l_div;
R_div=@(x)  slope_div*(x-l_con)+r_t;
A_div=@(x) pi*(R_div(x))^2;

%Plotting the nozzle profile:
figure()
x_nozzle=[x_con,x_div];
r_nozzle=[R_con(x_con),R_div(x_div)];
plot(x_nozzle,r_nozzle)
xlabel('Length along the nozzle (in m)');
ylabel('Radial distance from centre line in (m)');
title('Nozzle Profile');
Mach_rel = @(M, A) (1/M)*((2/(gamma+1))*(1 +(gamma-1)/2*M^2))^((gamma+1)/(2*(gamma-1))) - (A/A_t);
Mach_solve=@(M_guess,A) fzero(@(M)Mach_rel(M,A),M_guess);
M_con=zeros(size(x_con));
M_div=zeros(size(x_div));
M_guess=[0.2, 2.5];
for i = 1:length(x_con)
    if abs(A_con(x_con(i)) - A_t) < 1e-8
        M_con(i) = 1;
    else
        M_con(i) = Mach_solve(0.7, A_con(x_con(i)));
    end
end
for i = 1:length(x_div)
    if abs(A_div(x_div(i)) - A_t) < 1e-8
        M_div(i) = 1;
    else
        M_div(i) = Mach_solve(2.5, A_div(x_div(i)));
    end
end
M_nozzle=[M_con,M_div];
M_exit=M_nozzle(end);
%Plotting the nozzle profile:
figure()
x_nozzle=[x_con,x_div];
plot(x_nozzle,M_nozzle)
xlabel('Length along the nozzle (in m)');
ylabel('Mach Number');
title('Mach Number Profile Along the Nozzle');

%Pressure and Temperature Calculations:
T_o=300; P_o=6700000;
T = @(M) T_o /(1 +(gamma-1)/2*M^2);
P = @(M) P_o/((1 +(gamma-1)/2*M^2)^(gamma/(gamma -1)));
P_nozzle=arrayfun(@(M)P(M),M_nozzle);
T_nozzle=arrayfun(@(M)T(M),M_nozzle);

figure()
plot(x_nozzle,P_nozzle)
xlabel('Length along the nozzle (in m)');
ylabel('Pressure (in Pascals)');
title('Pressure Along the Nozzle');

figure()
plot(x_nozzle,T_nozzle)
xlabel('Length along the nozzle (in m)');
ylabel('Temperature (in K)');
title('Temperature Along the Nozzle');

%Modelling the free jet:
x_domain=[x_nozzle,x_jet];
k=12;
M_jet_fun = @(x) max(0, M_exit*(1-(x-(l_con+l_div))/(k*2*r_2)));
M_jet=arrayfun(@(x)M_jet_fun(x),x_jet);
M_domain=[M_nozzle,M_jet];

figure()
plot(x_domain,M_domain)
xlabel('Length in the streamwise direction (in m)');
ylabel('Mach Nubmer');
title('Mach Number across the domain');

P_jet=arrayfun(@(M)P(M), M_jet);
T_jet=arrayfun(@(M)T(M), M_jet);
P_domain=[P_nozzle,P_jet];
T_domain=[T_nozzle,T_jet];

figure()
plot(x_domain,P_domain)
xlabel('Length in the streamwise direction (in m)');
ylabel('Pressure (in Pascals)');
title('Pressure across the domain');

figure()
plot(x_domain,T_domain)
xlabel('Length in the streamwise direction (in m)');
ylabel('Temperature (in K)');
title('Temperature across the domain');

%Calculating the mass flow rate:
R=287; %for air as the working fluid
No_of_Nozzles=9;
m_fr_chocked=A_t*P_o*((gamma/(R*T_o))^(1/2))*(2/(gamma+1))^((gamma+1)/(2*(gamma-1)));
m_fr_chocked_total=No_of_Nozzles*m_fr_chocked;


