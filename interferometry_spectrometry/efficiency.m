close all;clc;
% Strahlungsausbeute %

%% Read measurement data
measure1 = importdata("interferometry_spectrometry/Versuch3/20mA_2_6V.txt");
measure2 = importdata("interferometry_spectrometry/Versuch3/40mA_2_7V.txt");
measure3 = importdata("interferometry_spectrometry/Versuch3/60mA_2_7V.txt");
measure4 = importdata("interferometry_spectrometry/Versuch3/80mA_2_8V.txt");
measure5 = importdata("interferometry_spectrometry/Versuch3/100mA_2_8V.txt");
measure6 = importdata("interferometry_spectrometry/Versuch3/120mA_2_8V.txt");
measure7 = importdata("interferometry_spectrometry/Versuch3/140mA_2_8V.txt");
measure8 = importdata("interferometry_spectrometry/Versuch3/160mA_2_9V.txt");
measure9 = importdata("interferometry_spectrometry/Versuch3/180mA_2_9V.txt");
measure10 = importdata("interferometry_spectrometry/Versuch3/200mA_2_9V.txt");

%% ne=I/P
ne1= measure1(1:end,2)/(0.02*2.6);
ne2= measure2(1:end,2)/(0.04*2.7);
ne3= measure3(1:end,2)/(0.06*2.7);
ne4= measure4(1:end,2)/(0.08*2.8);
ne5= measure5(1:end,2)/(0.1*2.8);
ne6= measure6(1:end,2)/(0.12*2.8);
ne7= measure7(1:end,2)/(0.14*2.8);
ne8= measure8(1:end,2)/(0.16*2.9);
ne9= measure9(1:end,2)/(0.18*2.9);
ne10= measure10(1:end,2)/(0.2*2.9);
figure;
title("Strahlungsausbeute");
hold on;
plot(measure1(1:end,1),ne1);
plot(measure2(1:end,1),ne2);
plot(measure3(1:end,1),ne3);
plot(measure4(1:end,1),ne4);
plot(measure5(1:end,1),ne5);
plot(measure6(1:end,1),ne7);
plot(measure7(1:end,1),ne8);
plot(measure8(1:end,1),ne9);
plot(measure9(1:end,1),ne10);
legend("20mA-2.7V","40mA-2.7V","60mA-2.7V","80mA-2.8V","100mA-2.8V","120mA-2.8V","140mA-2.8V","160mA-2.9V","180mA-2.9V","200mA-2.9V");
% Man sieht im Plot,dass eine höhere Verlustleistung bei steigendem Strom
% entsteht, die höchste Ausbeute wird bei 60mA erreicht.

