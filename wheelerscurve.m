%% Wheelers Curve for Microstrip Lines Simulation
% Simulated by Abhiram S
%------------------------------------------------------------------------
% Function to compute Microstrip Impedances
% function z = wlrfrm(kr,wh)
% keff=(kr+1)/2+(kr-1)/2*(1+12./wh).^-0.5;
% q=keff.^-0.5;
% q1=q(wh<1);
% q2=q(wh>=1);
% z=zeros(1,length(wh));
% wh1=wh(wh<1);
% wh2=wh(wh>=1);
% z(wh<1)=60*q1.*log(8./wh1 + wh1./4);
% z(wh>=1)=120*pi*q2./(wh2 + 1.393 + 0.667*log(wh2 + 1.444));
% end
%------------------------------------------------------------------------
% Obtaining and Plotting Wheelers Curve for different dielectrics
wh=0.2:0.2:30;
kr1=2.32; % Dielectric constant of Duroid
z1=wlrfrm(kr1,wh);
kr2=4.4; % Dielectric constant of FR4
z2=wlrfrm(kr2,wh);
kr3=10; % Dielectric constant of Alumina
z3=wlrfrm(kr3,wh);
plot(z1,wh,z2,wh,'--',z3,wh,'-.');
grid on
grid minor
title('Wheelers Curve');
ylabel('Width to Height Ratio w/h');
xlabel('Microstrip Impedance Z');
legend('Duroid, \epsilon_{r} = 2.32','FR4, \epsilon_{r} = 4.4',...
    'Alumina, \epsilon_{r} = 10');