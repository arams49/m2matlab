%% Coupled Stripline Bandpass Filter Design
% Done by Abhiram (108115074), Satheeshwar (108115078), Kevin (108115046)

%% Design Specifications
fc = 3.17e9;  % Center Frequency
n = 3;  % Order of Filter
fbw = 0.2;  % Fractional bandwidth
w1p = 1;  % Prototype Passband edge frequency
Z0 = 50;  % Terminating Impedance
er = 10.2;  % Relative Permittivity of Duroid


%% Butterworth Filter Prototype Values
k = 1:n;  r = 1;
g = 2*sin((2*k-1)*pi/2/n);
g = [1,g,r];  % Prototype Filter Coefficients from 0 to n+1
display('Prototype Filter Coefficients are'); disp(g);


%% K Inverter values
K = zeros(1,n+1);  % K Inverter values
K(1) = Z0 / sqrt(pi*fbw/(2*g(1)*g(2)*w1p));
for t = 2:n
    K(t) = Z0 / (pi*fbw/(2*w1p*sqrt(g(t)*g(t+1))));
end
K(n+1) = Z0 / sqrt(pi*fbw/(2*g(n+1)*g(n+2)*w1p));
display('K Inverter values are (in ohms)'); disp(K);


%% Odd Mode and Even Mode Impedances
zk = Z0./K;
Zoe = Z0*(1 + zk + zk.^2);  % Even Mode Impedance
Zoo = Z0*(1 - zk + zk.^2);  % Odd Mode Impedance
display('Even Mode Impedances are (in ohms)'); disp(Zoe);
display('Odd Mode Impedances are (in ohms)'); disp(Zoo);


%% Impedance values for Stripline Nomogram
Zoe1 = Zoe * sqrt(er);
Zoo1 = Zoo * sqrt(er);
display('Even Mode Nomogram Impedances are (in ohms)'); disp(Zoe1);
display('Odd Mode Nomogram Impedances are (in ohms)'); disp(Zoo1);


%% Width and Separation ratios using Nomogram
wb = [0.08, 0.16, 0.16, 0.08];  % Empirical Width Ratio
sb = [0.08, 0.24, 0.24, 0.08];  % Empirical Separation Ratio


%% Verifying the accuracy of the empirical ratios
ke = tanh(pi*wb/2).*tanh(pi/2*(wb+sb));
ko = tanh(pi*wb/2).*coth(pi/2*(wb+sb));
kep = sqrt(1-ke.^2);
kop = sqrt(1-ko.^2);
Kke = pi ./ log(2*(1+sqrt(kep))./(1-sqrt(kep)));
Kko = pi ./ log(2*(1+sqrt(kop))./(1-sqrt(kop)));
Zoef = 30*pi./Kke/sqrt(er);  % Even Mode Impedance by formula
Zoof = 30*pi./Kko/sqrt(er);  % Odd Mode Impedance by formula
display('Original Impedance (Even Mode) (in ohms)'); disp(Zoe);
display('Designed Impedance (Even Mode) (in ohms)'); disp(Zoef);
display('Original Impedance (Odd Mode) (in ohms)'); disp(Zoo);
display('Designed Impedance (Odd Mode) (in ohms)'); disp(Zoof);


%% Layout Design Values of K Inverters
b = 25;  % Height of Stripline in mm
wi = wb * b;  % Width of Stripline in mm
si = sb * b;  % Separation b/w Stripline in mm
lambdag = 3e8/fc/sqrt(er);
l = lambdag / 4 *1000;  % Length of Coupled section in mm
li = l * ones(1,n+1);
bi = b * ones(1,n+1);
index = 1:n+1;

display('Layout Design Values using Coupled Stripline');
fprintf('Section         '); fprintf('%9d  ',index); fprintf('\n');
fprintf('Width (mm)      '); fprintf('%9.3f  ',wi); fprintf('\n');
fprintf('Separation (mm) '); fprintf('%9.3f  ',si); fprintf('\n');
fprintf('Height (mm)     '); fprintf('%9.2f  ',bi); fprintf('\n');
fprintf('Length (mm)     '); fprintf('%9.3f  ',li); fprintf('\n');


%% Characteristics of Terminating Impedance Line
x = 30*pi/Z0/sqrt(er) - 0.441;
wtb = 0.85 - sqrt(0.6 - x);
wt = wtb * b;
lt = l;
fprintf('Terminating Stripline Width is %.3f mm\n',wt);
fprintf('Terminating Stripline Length is %.3f mm',lt);