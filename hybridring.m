%% Scattering Parameters of Hybrid Ring Coupler
%------------------------------------------------------------------------
% Program to calculate Scattering Parameters of Hybrid Ring Coupler
% The Program gives a formulaic representation of Scattering Parameters
% If values of Scattering Parameters are required, ...
%  then Ya, Yb and Yo can be initialised accordingly
% Written by Abhiram S
%------------------------------------------------------------------------
% Ya = Admittance of T.L. between Ports 1 & 4, and Ports 2 & 3
% Yb = Admittance of T.L. between Ports 1 & 2, and Ports 3 & 4
% Yo = Terminating Impedances of Ports 1,2,3,4
%------------------------------------------------------------------------

%% Parameter Initialization
syms Ya Yb Yo;
theta = sym(pi/4);  % Electrical Angle

%% Transmission Matrix (T.M.)
T1e = [1,0; j*Ya*tan(3*theta),1];  % T.M. 1 for even mode
T1o = [1,0; -j*Ya/tan(3*theta),1];  % T.M. 1 for odd mode
T2 = [cos(2*theta),j*sin(2*theta)/Yb; j*sin(2*theta)*Yb,cos(2*theta)];  % T.M. 2
T3e = [1,0; j*Ya*tan(theta),1];  % T.M. 3 for even mode
T3o = [1,0; -j*Ya/tan(theta),1];  % T.M. 3 for odd mode


%% Overall ABCD Matrix of Even and Odd Mode
TMeven = T1e * T2 * T3e;  % ABCD Matrix of Even Mode
TModd = T1o * T2 * T3o;  % ABCD Matrix of Odd Mode
deltaE = TMeven(1,1) + TMeven(1,2)*Yo + TMeven(2,1)/Yo + TMeven(2,2);
deltaO = TModd(1,1) + TModd(1,2)*Yo + TModd(2,1)/Yo + TModd(2,2);


%% Scattering Parameter Matrix of Even and Odd Mode
SE(1,1) = (TMeven(1,1)+TMeven(1,2)*Yo-TMeven(2,1)/Yo-TMeven(2,2))/deltaE;
SE(1,2) = 2*(TMeven(1,1)*TMeven(2,2)-TMeven(1,2)*TMeven(2,1))/deltaE;
SE(2,1) = 2/deltaE;
SE(2,2) = (-TMeven(1,1)+TMeven(1,2)*Yo-TMeven(2,1)/Yo+TMeven(2,2))/deltaE;
SE = simplify(SE);  % Even Mode Scattering Parameter Matrix 


SO(1,1) = (TModd(1,1)+TModd(1,2)*Yo-TModd(2,1)/Yo-TModd(2,2))/deltaO;
SO(1,2) = 2*(TModd(1,1)*TModd(2,2)-TModd(1,2)*TModd(2,1))/deltaO;
SO(2,1) = 2/deltaO;
SO(2,2) = (-TModd(1,1)+TModd(1,2)*Yo-TModd(2,1)/Yo+TModd(2,2))/deltaO;
SO = simplify(SO);  % Odd Mode Scattering Parameter Matrix


%% Scattering Parameters S11, S12, S13, S14 of Hybrid Ring Coupler
S1(1) = (SE(1,1) + SO(1,1))/2;  % S11
S1(2) = (SE(1,2) + SO(1,2))/2;  % S12
S1(3) = (SE(1,2) - SO(1,2))/2;  % S13
S1(4) = (SE(1,1) - SO(1,1))/2;  % S14
S1 = simplify(S1);
pretty(S1);