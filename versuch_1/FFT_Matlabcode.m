clear all;
%Signalauswertung Messreihen
load('durchfuehrung/Versuch_4_12kmh_10ohm/Messung_4.fig','-mat')

%Signal an der Felge
Kind=extractfield(hgS_070000,'children');
Kind_struct=Kind{1,1};
Kind2=extractfield(Kind_struct,'children');
Kind_struct2=Kind2{1,4};
Properties=extractfield(Kind_struct2,'properties');
Datenausproperties=Properties{1,1};
X_Felge=extractfield(Datenausproperties,'XData');
Y_Felge=extractfield(Datenausproperties,'YData');
Y_Felg=double(Y_Felge);
% Signal an der Achse
Kind_Achse=extractfield(hgS_070000,'children');
Kind_structAchse=Kind_Achse{1,1};
Kind2_Achse=extractfield(Kind_structAchse,'children');
Kind_struct2Achse=Kind2_Achse{1,5};
PropertiesAchse=extractfield(Kind_struct2Achse,'properties');
DatenauspropertiesAchse=PropertiesAchse{1,1};
X_Achse=extractfield(DatenauspropertiesAchse,'XData');
Y_Achse=extractfield(DatenauspropertiesAchse,'YData');
Y_Ach=double(Y_Achse);

N_Felge=length(X_Felge);
N_Achse=length(X_Achse);
dt=1e-4;
fs=1/dt;
df=1/(N_Achse*dt);
f_xaxis=-fs/2:df:fs/2-df;

% Y_Felge1=Y_Felge(d:end);
% Y_Achse1=Y_Achse(d:end);

FFT_Felge=fft(Y_Felg-mean(Y_Felg));
FFT_Felge(1)=0;
FFT_Felge_shift=fftshift(FFT_Felge);
FFT_Achse=fft(Y_Ach-mean(Y_Ach));
FFT_Achse(1)=0;
FFT_Achse_shift=fftshift(FFT_Achse);
[~,idx]=max(abs(FFT_Felge_shift));
phi1=atan2(imag(FFT_Felge_shift(idx)),real(FFT_Felge_shift(idx)))*180/pi;
phi2=atan2(imag(FFT_Achse_shift(idx)),real(FFT_Achse_shift(idx)))*180/pi;
Deltaphi=abs(phi2-phi1);
KON=89.5360;
phiTorsion=abs(KON-Deltaphi);
M=(phiTorsion*300)/36;

% figure(2);
% subplot(2,1,1);
% plot(f_xaxis/1e3,FFT_Felge_shift/N_Felge);
% subplot(2,1,2);
% plot(f_xaxis/1e3,FFT_Achse_shift/N_Achse);

figure(1);
subplot(2,2,1);
plot(X_Felge,Y_Felge);
xlabel('Zeit in Sekunden');
ylabel('Ampl. ADC-Werte');
hold on;
plot(X_Achse,Y_Achse);
legend('Signal Felge Last','Signal Achse Last');


