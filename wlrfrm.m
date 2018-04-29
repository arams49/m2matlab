function z = wlrfrm(kr,wh)
%--------------------------------------------------------------------------
% Function to calculate Microstrip Line Impedance
% Written by Abhiram S
%--------------------------------------------------------------------------
% Input Arguments = (kr,wh)
% kr = Dielectric Constant of Material
% wh = Array of Width per unit height values
%--------------------------------------------------------------------------
% Output Arguments = z
% z = Microstrip Line Impedance corresponding to given width per height
%--------------------------------------------------------------------------
keff=(kr+1)/2+(kr-1)/2*(1+12./wh).^-0.5;
q=keff.^-0.5;
q1=q(wh<1);
q2=q(wh>=1);
z=zeros(1,length(wh));
wh1=wh(wh<1);
wh2=wh(wh>=1);
z(wh<1)=60*q1.*log(8./wh1 + wh1./4);
z(wh>=1)=120*pi*q2./(wh2 + 1.393 + 0.667*log(wh2 + 1.444));
end