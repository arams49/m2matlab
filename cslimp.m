function [Zoe,Zoo] = cslimp(wb, sb, kr)
%----------------------------------------------------------
% Function to calculate Impedance of a Coupled Stripline
% Written by Abhiram S
%----------------------------------------------------------
% Input Arguments = (wb,sb,kr)
% wb = Width per unit height
% sb = Separation per unit height
% kr = Dielectric Constant of Stripline material
%----------------------------------------------------------
% Output Arguments = [Zoe,Zoo]
% Zoe = Even Mode Impedance
% Zoo = Odd Mode Impedance
%----------------------------------------------------------

ke = tanh(pi*wb/2).*tanh(pi/2*(wb+sb));
ko = tanh(pi*wb/2).*coth(pi/2*(wb+sb));
kep = sqrt(1-ke.^2);
kop = sqrt(1-ko.^2);
Zoe = 30*pi/sqrt(kr)*ellipke(kep,eps*10000)./ellipke(ke,eps*10000);
Zoo = 30*pi/sqrt(kr)*ellipke(kop,eps*10000)./ellipke(ko,eps*10000);

end