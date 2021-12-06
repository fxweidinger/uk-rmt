%clear
load('durchfuehrung/Kalibrierung 6.95kg/Piezo_Daten.mat')
%load('C:\Users\Halli\Desktop\Uni\RMV\Dremoment Versuch\Messdaten\Kalibrierung 7kg\DMS_Daten.mat')
%Umwandeln des Datentypes in double
Piezo_Data=double(Piezo_Data);
%Offset ermitteln
offset=mean(Piezo_Data);

load('durchfuehrung/Versuch 1_8kmh_8ohm/Piezo_Daten.mat')

Piezo_Data=double(Piezo_Data);

%Offset abziehen und ADC Werte in Spannung umwandeln
U_Piezo=((Piezo_Data-offset)*3.3)/4096;

%Kraft am Pedal ausrechnen
F_Piezo=-(((U_Piezo)*300e-9)/300e-12);

%Drehmoment am Pedal
M_DMS=(F_Piezo)*0.16;
%Kraft an der Kette
F_tan=M_DMS/0.07;
%Drehmoment am Hinterrad abzüglich Wirkungsgrad
M_2=F_tan*(0.1362/2)*0.98;
title('Drehmomentmessung mit DMS')
ylabel('Drehmoment in Nm')
xlabel('t in ms')


plot(M_2)
