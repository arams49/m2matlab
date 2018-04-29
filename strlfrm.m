function z = strlfrm(kr,wh)
%--------------------------------------------------------------------------
% Function to calculate Stripline Impedance
% Written by Abhiram S
%--------------------------------------------------------------------------
% Input Arguments = (kr,wh)
% kr = Dielectric Constant of Material
% wh = Array of Width per unit height values
%--------------------------------------------------------------------------
% Output Arguments = z
% z = Stripline Impedance corresponding to given width per height
%--------------------------------------------------------------------------
q=kr^-0.5;
weh=zeros(1,length(wh));  % Effective Width of each Width/Height value
wh1=wh(wh<0.35);
wh2=wh(wh>=0.35);
weh(wh<0.35)=wh1-(0.35-wh1).^2;
weh(wh>=0.35)=wh2;
z=30*pi*q./(weh+0.441);
end
