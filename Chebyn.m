function chb = Chebyn(M,Am)
%-------------------------------------------------------------------------
% Function to calculate Chebyshev Filter Coefficients
%  for orders 1 to M and ripple Am (in dB)
% Written by Abhiram S
%-------------------------------------------------------------------------
% Input Arguments = (M,Am)
% M = Max. Order of Chebyshev Filter
% Am = Ripple Factor in decibels (dB)
%-------------------------------------------------------------------------
% Output Arguments = [chb]
% chb = Table of Chebyshev Filter Coefficients,
%       where row n contains n'th Order Coefficients
%-------------------------------------------------------------------------

chb=zeros(M,M+2);  % Table of Chebyshev Filter Coefficients
for n=1:M
    b=log(coth(Am/17.37));
    y=sinh(b/(2*n));
    k=1:n;
    ak=sin((2*k-1)*pi/(2*n));
    bk=y^2+(sin(k*pi/n)).^2;
    chb(n,1)=1;
    chb(n,2)=2*ak(1)/y;
    for p=2:n
        chb(n,p+1)=4*ak(p-1)*ak(p)/(bk(p-1)*chb(n,p));
    end
    if mod(n,2)==0
        chb(n,n+2)=(tanh(b/4))^2;
    else
        chb(n,n+2)=1;
    end
end

% Printing Chebyshev Filter Coefficients
fprintf('Order');
for k=1:M+2
    fprintf(['   g',num2str(k-1),'   ']);
end
fprintf('\n');
for n=1:M
    fprintf('%3d  ',n);
    fprintf(' %6.4f ',chb(n,:));
    fprintf('\n');
end
fprintf('\n');
end