close all; clc 
%Import generator data into structs (for loop would have been easier..) 
current= load("versuch_1/durchfuehrung/Versuch 6_8kmh_6ohm/Current_RawData.mat");
voltage=load("versuch_1/durchfuehrung/Versuch 6_8kmh_6ohm/Voltage_RawData.mat");
gd_8K_6R.Current_Data=current.Current_Data;
gd_8K_6R.Voltage_Data=voltage.Voltage_Data;
current= load("versuch_1/durchfuehrung/Versuch 7_10kmh_6ohm/Current_RawData.mat");
voltage=load("versuch_1/durchfuehrung/Versuch 7_10kmh_6ohm/Voltage_RawData.mat");
gd_10K_6R.Current_Data=current.Current_Data;
gd_10K_6R.Voltage_Data=voltage.Voltage_Data;
current= load("versuch_1/durchfuehrung/Versuch 2_8kmh_10ohm/Current_RawData.mat");
voltage=load("versuch_1/durchfuehrung/Versuch 2_8kmh_10ohm/Voltage_RawData.mat");
gd_8K_10R.Current_Data=current.Current_Data;
gd_8K_10R.Voltage_Data=voltage.Voltage_Data;
clear voltage current;
current= load("versuch_1/durchfuehrung/Versuch 1_8kmh_8ohm/Current_RawData.mat");
voltage=load("versuch_1/durchfuehrung/Versuch 1_8kmh_8ohm/Voltage_RawData.mat");
gd_8K_8R.Current_Data=current.Current_Data;
gd_8K_8R.Voltage_Data=voltage.Voltage_Data;
clear voltage current;
current= load("versuch_1/durchfuehrung/Versuch 5_6.5kmh_6ohm/Current_RawData.mat");
voltage=load("versuch_1/durchfuehrung/Versuch 5_6.5kmh_6ohm/Voltage_RawData.mat");
gd_6_5K_6R.Current_Data=current.Current_Data;
gd_6_5K_6R.Voltage_Data=voltage.Voltage_Data;
clear voltage current;

%% Initialising sample rate, time vector 
Fs=1000;
f = 1000*(0:(9984/2))/9984;
t=0:0.001:10.00-0.016-0.001; 

%% Initialising stuff
v_rad=[6.5/3.6 8/3.6 10/3.6];
r_rad=0.7112/2;
n_rad=(v_rad/r_rad)*(60/(2*pi));

%% Calculating output (P)
U_a1=calc_voltage(gd_6_5K_6R.Voltage_Data,7.5e3,1.5e3);
U_a2=calc_voltage(gd_8K_6R.Voltage_Data,7.5e3,1.5e3);
U_a3=calc_voltage(gd_8K_8R.Voltage_Data,7.5e3,1.5e3);
U_a4=calc_voltage(gd_8K_10R.Voltage_Data,7.5e3,1.5e3);
U_a5=calc_voltage(gd_10K_6R.Voltage_Data,7.5e3,1.5e3);
I_a1=calc_current(gd_6_5K_6R.Current_Data,220e3,110e3,0.1);
I_a2=calc_current(gd_8K_6R.Current_Data,220e3,110e3,0.1);
I_a3=calc_current(gd_8K_8R.Current_Data,220e3,110e3,0.1);
I_a4=calc_current(gd_8K_10R.Current_Data,220e3,110e3,0.1);
I_a5=calc_current(gd_10K_6R.Current_Data,220e3,110e3,0.1);

% Internal Resistance
R_i=-(mean(U_a4)-mean(U_a2))/(mean(I_a4)-mean(I_a2));
U_ind1=U_a1+R_i*I_a1;
U_ind2=U_a2+R_i*I_a2;
U_ind3=U_a3+R_i*I_a3;
U_ind4=U_a4+R_i*I_a4;
U_ind5=U_a5+2*R_i*I_a5;

% Resulting Power
P1=U_ind1.*I_a1;
P2=U_ind2.*I_a2;
P3=U_ind3.*I_a3;
P4=U_ind4.*I_a4;
P5=U_ind5.*I_a5;

figure("Name","Power");
hold on;
%plot(t,P1,"DisplayName","6,5kmh 6ohm");
plot(t,P2);
plot(t,P3);
plot(t,P4);
title('Leistung bei 8 km/h und variiertem Widerstand')
legend('8kmh 6ohm, Mean=128.55','8kmh 8ohm, Mean=101.90','8kmh 10ohm, Mean= 81.79')
xlabel('t [s]')
ylabel('P [Watt]')
%plot(t,P5,"DisplayName","10kmh 6ohm");
hold off;

%% Calculating torque (M)
% Efficiency coefficient (Manually inserted from kennlinie.pdf...)
eta1=0.53;
eta2=0.61;
eta3=0.55;
eta4=0.52;
eta5=0.65;
M1= (P1)./((eta1)*(2*pi*n_rad(1)/60));
M2= (P2)./((eta2)*(2*pi*n_rad(2)/60));
M3= (P3)./((eta3)*(2*pi*n_rad(2)/60));
M4= (P4)./((eta4)*(2*pi*n_rad(2)/60));
M5= (P5)./((eta5)*(2*pi*n_rad(3)/60));
figure("Name","Torque");
hold on;
title('Drehmomente bei 8 km/h bei variiertem Widerstand')
plot(t,M2);
plot(t,M3);
plot(t,M4);
legend('8kmh 6ohm, Mean=33.72','8kmh 8ohm, Mean=29.65','8kmh 10ohm, Mean= 25.17')
xlabel('t [s]')
ylabel('M [Nm]')
hold off;
mean(M1)
mean(M2)
mean(M3)
mean(M4)
mean(M5)
max(M1)
max(M2)
max(M3)
max(M4)
max(M5)




% 
% figure("Name","By Time")
% plot(t,gd_6_5K_6R.Voltage_Data)
% s= gd_10K_6R.Current_Data-mean(gd_10K_6R.Current_Data)
% test= fft(s)
% P2=abs(test/9984);
% P1=P2(1:9984/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% figure("Name","Frequency Spectrum 10K 6R")
% plot(f,P1)
% test= fft(gd_8K_6R.Voltage_Data)
% P2=abs(test/9984);
% P1=P2(1:9984/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% figure("Name","Frequency Spectrum 8K 6R")
% plot(f,P1)
% test=gd_8K_10R.Voltage_Data-mean(gd_8K_10R.Voltage_Data)
% test= fft(test)
% P2=abs(test/9984);
% P1=P2(1:9984/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% figure("Name","Frequency Spectrum 8K 10R")
% plot(f,P1)
% test= gd_8K_6R.Voltage_Data-mean(gd_8K_6R.Voltage_Data)
% test= fft(test)
% P2=abs(test/9984);
% P1=P2(1:9984/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% figure("Name","Frequency Spectrum 8K 8R")
% plot(f,P1)
% s= gd_6_5K_6R.Voltage_Data%-mean(gd_6_5K_6R.Voltage_Data)
% test= fft(s)
% P2=abs(test/9984);
% P1=P2(1:9984/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% figure("Name","Frequency Spectrum 6.5K 6R")
% plot(f,P1)
% figure("Name","6_5K plot")
% hold on;
% x=133.*sin(2*pi*0.901442*(t-1.5*pi))+mean(gd_6_5K_6R.Voltage_Data)
% y=226.931.*cos(2*pi*1.70272*t)+mean(gd_6_5K_6R.Voltage_Data)
% z=(133*cos(2*pi*0.901442*t)+226.931*cos(2*pi*1.70272*t))+mean(gd_6_5K_6R.Voltage_Data)
% plot(t,gd_6_5K_6R.Voltage_Data,"red");
% plot(t,x,"blue")
% plot(t,y,"green")
% plot(t,x+y-mean(gd_6_5K_6R.Voltage_Data),"yellow")
% plot(t,z,"black")
%figure("Name","gauss")
%gaustest= gaussfilt(t,gd_6_5K_6R.Voltage_Data,10000)
%plot(t,gaustest)