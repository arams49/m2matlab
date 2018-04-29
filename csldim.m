function [w,s,err] = csldim(Zoe, Zoo, kr)
%---------------------------------------------------------- 
% Function to calculate Dimension of a Coupled Stripline
% Written by Abhiram S
%----------------------------------------------------------
% Input Arguments = (Zoe,Zoo,kr)
% Zoe = Even Mode Impedance
% Zoo = Odd Mode Impedance
% kr = Dielectric Constant of Stripline material
%----------------------------------------------------------
% Output Arguments = [w,s,err]
% w = Width per unit height
% s = Separation per unit height
% err = Average Error of the Impedances
%----------------------------------------------------------

Nw = 125; Ns = 121;
w = zeros(size(Zoe));
s = zeros(size(Zoe));
err = zeros(size(Zoe));
for t = 1 : length(Zoe)
    Za = Zoe(t) * sqrt(kr);
    Zb = Zoo(t) * sqrt(kr);
    wb = linspace(0.02,2.5,Nw);
    sb = logspace(-3,0,Ns);
    tmp = realmax;
    for p = 1 : length(wb)
        for q = 1 : length(sb)
            ke = tanh(pi*wb(p)/2).*tanh(pi/2*(wb(p)+sb(q)));
            ko = tanh(pi*wb(p)/2).*coth(pi/2*(wb(p)+sb(q)));
            kep = sqrt(1-ke.^2);
            kop = sqrt(1-ko.^2);
            Z1 = 30*pi*ellipke(kep,eps*10000)/ellipke(ke,eps*10000);
            Z2 = 30*pi*ellipke(kop,eps*10000)/ellipke(ko,eps*10000);
            tz = sqrt(((Za - Z1)^2 + (Zb - Z2)^2)/2);
            if (tz<tmp)
                tmp = tz;
                w(t) = wb(p);
                s(t) = sb(q);
            end
        end
    end
    err(t) = tmp/sqrt(kr);
end
end