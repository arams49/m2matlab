%% Impedance Curve for Stripline Simulation
%------------------------------------------------------------------------
% Function to compute Stripline Impedance Curve
% Simulated by Abhiram S
%------------------------------------------------------------------------
% Function to calculate Stripline Impedance
% function z = strlfrm(kr,wh)
% q=kr^-0.5;
% weh=zeros(1,length(wh));
% wh1=wh(wh<0.35);
% wh2=wh(wh>=0.35);
% weh(wh<0.35)=wh1-(0.35-wh1).^2;
% weh(wh>=0.35)=wh2;
% z=30*pi*q./(weh+0.441);
% end
%------------------------------------------------------------------------
% Obtaining and Plotting Impedance Curve for different dielectrics
wh=0.1:0.1:10;
kr1=2.32; % Dielectric constant of Duroid
z1=strlfrm(kr1,wh);
kr2=4.4; % Dielectric constant of FR4
z2=strlfrm(kr2,wh);
kr3=10; % Dielectric constant of Alumina
z3=strlfrm(kr3,wh);
plot(z1,wh,z2,wh,'--',z3,wh,'-.');
grid on
grid minor
title('Impedance Curve for Stripline');
ylabel('Width to Height Ratio w/h');
xlabel('Stripline Impedance Z');
legend('Duroid, \epsilon_{r} = 2.32','FR4, \epsilon_{r} = 4.4',...
    'Alumina, \epsilon_{r} = 10');