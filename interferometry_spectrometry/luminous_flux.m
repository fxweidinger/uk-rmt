%% Author:Felix Weidinger - January 2022
close all;clc;
%% Read data of green LED and radiant flux 
%norma = @(a) a./norm(a);
greenLedDataRaw = importdata("interferometry_spectrometry/green_led.txt");
wavelength=greenLedData(1:end,1);

%Round wavelengths to .1 accuracy
greenLedDataRounded=[round(greenLedDataRaw(1:end,1),1) greenLedDataRaw(1:end,2)];

%Remove Rows 0->133 & 1241->end that lie outside the sensitivity of the
%human eye 380nm -> 790nm
greenLedDataHumanSensitivity=greenLedDataRounded(134:1241,:);

%% Import luminous efficacy data and compute luminous efficacy factor for each wavelength in the acquired spectrum
V=importdata("interferometry_spectrometry/linCIE2008v2e_fine.csv");
greenLedDataHumanSensitivity(1:end,2)=10^-6*greenLedDataHumanSensitivity(1:end,2);
for i=1:length(greenLedDataHumanSensitivity(1:end,1))
   x=find(V==greenLedDataHumanSensitivity(i,1));
   temp=V(x,2);
   y(i,1)=temp;
end

%% Calculate luminous flux 
Km=683;
coeff=(greenLedDataHumanSensitivity(end,1)-greenLedDataHumanSensitivity(1,1))/length(greenLedDataHumanSensitivity);
luminousFlux=Km*sum(greenLedDataHumanSensitivity(1:end,2).*y(:,1)*coeff);
display(luminousFlux);




%greenLedDataHumanSensitivity(1:end,2)=(greenLedDataHumanSensitivity(1:end,2)/max(greenLedDataHumanSensitivity(1:end,2)));




