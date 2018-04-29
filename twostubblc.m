function [Ya,Yb,Yc] = twostubblc (Cdb)
%---------------------------------------------------------- 
% Function to calculate branch admittances Ya, Yb, Yc
%  of a Two-Stub Branch-Line Coupler
% Written by Abhiram S
%----------------------------------------------------------
% Input Arguments = (Cdb)
% Cdb = Mean Coupling in decibels (dB)
%----------------------------------------------------------
% Output Arguments = [Ya,Yb,Yc]
% Ya = Branch Admittance between Ports 1 and 2 (in mho)
% Yb = Branch Admittance between Ports 1 and 4 (in mho)
% Yc = Terminating Branch Admittance (in mho)
%----------------------------------------------------------

S13 = 10.^(-Cdb/20);  % Scattering Parameter S13
S12 = sqrt(1-S13.^2);  % Scattering Parameter S12
kc = ones(size(Cdb));  % Coefficient of Yc
ka = kc./S12;  % Coefficient of Ya
kb = ka.*S13;  % Coefficient of Yb
Y0 = 1/50;  % Terminating Admittance (in mho)
Ya = ka * Y0;
Yb = kb * Y0;
Yc = kc * Y0;
index = 1:length(Cdb);

% Displaying the Result
fprintf('\n');
display('Branch Admittances of Two Stub Branch Line Coupler');
fprintf('\n');
fprintf('Section                '); fprintf('%10d   ',index); fprintf('\n');
fprintf('Mean Coupling (dB)     '); fprintf('%10.2f   ',Cdb); fprintf('\n');
fprintf('Branch Admittance Ya   '); fprintf('%7.4f*Y0   ',ka); fprintf('\n');
fprintf('Branch Admittance Yb   '); fprintf('%7.4f*Y0   ',kb); fprintf('\n');
fprintf('Branch Admittance Yc   '); fprintf('%7.4f*Y0   ',kc); fprintf('\n');
fprintf('\n');
end