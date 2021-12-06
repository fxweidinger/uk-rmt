clear;
load('durchfuehrung/Kalibrierung 6.95kg/DMS_Daten.mat')

%Umwandeln des Datentypes in double
DMS_Data=double(DMS_Data);
% Berechnung der Steigung anhand Kalibrierungsmessdaten
m=(1.76-1.69)/(132-69.5);

% Offset ermitteln c=Ub-mF

offset=(mean(DMS_Data)*3.3/4096)-m*69.5;

%Vorher gewünschte Messdaten manuell laden
load('durchfuehrung/Versuch 1_8kmh_8ohm/DMS_Daten.mat')
DMS_Data=double(DMS_Data)
%Umwandlung der ADC-Werte in Spannung
U_DMS=(DMS_Data)*3.3/4096;
U_DMS=U_DMS-offset;

%Drehmoment an Pedal ausrechnen
M_DMS=((U_DMS)/m)*0.16;

%Tangentialkraft der Kette berechnen
F_tan=M_DMS/0.07;

%Drehmoment am Hinterrad berechnen
M_2=F_tan*(0.1362/2)*0.98;
%hold on

%Ergebnisse plotten
hold on
plot(M_2)
grid on
title('Drehmomentmessung mit DMS 12 km/h 8 Ohm')
ylabel('Drehmoment in Nm')
xlabel('t in ms')