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

% figure("Name","8 km/h @ 8R & 10R ");
hold on;
plot(gd_8K_6R.Voltage_Data,"red");
plot(gd_8K_8R.Voltage_Data,"blue")
%plot(gd_8K_10R.Current_Data,"blue")

% Calculate internal resistance based on average 
delta_voltage10R_6R= mean(gd_8K_10R.Voltage_Data)-mean(gd_8K_6R.Voltage_Data);
delta_current10R_6R= mean(gd_8K_6R.Current_Data)-mean(gd_8K_10R.Current_Data);
R_1=delta_voltage10R_6R/delta_current10R_6R;
delta_voltage10R_8R= mean(gd_8K_10R.Voltage_Data)-mean(gd_8K_8R.Voltage_Data);
delta_current10R_8R= mean(gd_8K_8R.Current_Data)-mean(gd_8K_10R.Current_Data);
R_2=delta_voltage10R_8R/delta_current10R_8R;
delta_voltage8R_6R= mean(gd_8K_8R.Voltage_Data)-mean(gd_8K_6R.Voltage_Data);
delta_current8R_6R= mean(gd_8K_6R.Current_Data)-mean(gd_8K_8R.Current_Data);
R_3=delta_voltage8R_6R/delta_current8R_6R;
