clear all; close all;

%delimiterIn = '\t';
%% Read data of blue LED and luminous efficiency 
hold on;
%norma = @(a) a./norm(a);
greenLedData = importdata("interferometry_spectrometry/blue_test.txt");
wavelength=greenLedData(1:end,1);
radiatedPower=greenLedData(1:end,2);
radiatedPowerNorm= radiatedPower/norm(radiatedPower);
plot(wavelength,radiatedPowerNorm,"--");
V=importdata("interferometry_spectrometry/linCIE2008v2e_fine.csv");
V_normed=V/norm(V);
plot(V(1:end,1),V(1:end,2));
greenLedData_rounded=[round(greenLedData(1:end,1),1) greenLedData(1:end,2)];

%Remove Rows 0->133 & 1398->end that lie outside the sensitivity of the
%human eye.
%greenLedData_humansensitivity=greenLedData_rounded(134:1241,:);
greenLedData_humansensitivity=greenLedData_rounded(134:1059,:);
%greenLedData_humansensitivity=greenLedData_rounded(108:1059,:);

%% Calculate Luminous Flux
Km=683;
temp=(greenLedData_humansensitivity(1:end,2))/(norm(greenLedData_humansensitivity(1:end,2)))/1e4%%.*(greenLedData_humansensitivity(1:end,1));
%temp=norm(greenLedData_humansensitivity(1:end,2))/1e6%./(greenLedData_humansensitivity(1:end,1));
y=zeros(size(temp));
for i=1:length(greenLedData_humansensitivity(1:end,1))
   %display(i)
   %display(greenLedData_humansensitivity(i,1))
   %display(find(V==greenLedData_humansensitivity(i,1)))
   x=find(V==greenLedData_humansensitivity(i,1));
   %display(x);
   %display(V(x,2))
   shit=V(x,2);
   %display(shit);
   y(i,1)=shit;
end

temp3=(temp.*y);
temp4=sum(temp3);
Qv=Km*temp4;
