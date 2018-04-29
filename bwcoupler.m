function [Ze,Zo,wb,sb,err] = bwcoupler (Cdb,kr)
%---------------------------------------------------------- 
% Function to calculate impedances of Branch-wave Coupler
%  and plot coupling variation as a function of frequency
% Written by Abhiram S
%----------------------------------------------------------
% Input Arguments = (Cdb)
% Cdb = Mean Coupling in decibels (dB)
% kr = Dielectric Constant of Material
%----------------------------------------------------------
% Output Arguments = [Ze,Zo,wb,sb,err]
% Ze = Even Mode Impdedance
% Zo = Odd Mode Impedance
% wb = Width per unit height
% sb = Separation per unit height
% err = Average Error of the Impedances
%----------------------------------------------------------

%% Calculating the Impedances
Cv = 10.^(-Cdb/20);  % Coupling Coefficient
Zc = 50;  % Terminating Impedance
t = sqrt((1+Cv)./(1-Cv));
Ze = Zc.*t;  % Even Mode Impedance
Zo = Zc./t;  % Odd Mode Impedance
% kr = 10.2;  % Dielectric Constant of Duroid
[wb,sb,err] = csldim(Ze,Zo,kr);  % Dimensions of Coupled Stripline
index = 1:length(Cdb);

% Displaying the Result
fprintf('\n');
display('Layout Design Values of Backward-wave Coupler using Stripline');
fprintf('\n');
fprintf('Section              '); fprintf('%9d  ',index); fprintf('\n');
fprintf('Mean Coupling (dB)   '); fprintf('%9.2f  ',Cdb); fprintf('\n');
fprintf('Even Mode Imp (ohm)  '); fprintf('%9.3f  ',Ze); fprintf('\n');
fprintf('Odd Mode Imp (ohm)   '); fprintf('%9.3f  ',Zo); fprintf('\n');
fprintf('Width / Height       '); fprintf('%9.4f  ',wb); fprintf('\n');
fprintf('Separation / Height  '); fprintf('%9.4f  ',sb); fprintf('\n');
fprintf('Average Error (ohm)  '); fprintf('%9.3f  ',err); fprintf('\n');
fprintf('\n');

%% Plot the Coupling variation as a function of Normalized Frequency
fn = 0.1:0.01:1.9;  % Range of Normalized Frequency
theta = pi/2*fn;
txt = cell(length(Cdb),1);
figure;
for r = 1 : length(Cdb)
    V31 = (Cv(r))^2*(sin(theta)).^2 ./ (1-(Cv(r))^2*(cos(theta)).^2);
    func = -10*log10(V31);
    plot(fn,func);
    txt{r} = ['Mean Coupling = ', num2str(Cdb(r)), ' dB'];
    hold on;
end
legend(txt);
grid on;
grid minor;
xlabel('Normalized Frequency f / f_0');
ylabel('Coupling C (dB)');
title('Coupling variation for a Backward-wave Coupler');
end