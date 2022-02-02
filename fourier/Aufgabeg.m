clear all;
% sämtliche Parameter
% fs=1000; 
fa=80;
Zeitdauer=1; N=Zeitdauer*fa;
dt=1/fa;
t=0:dt:Zeitdauer-dt;

% Erzeugen der Signale s1,s2 für das gesamte Signal (Sig)
f1=20; a1=0.68;
f2=50; a2=1;

s1=a1*cos(2*pi*f1*t);
s2=a2*cos(2*pi*f2*t);
% Sig=s1+s2;
noise=2*0.47*rand(1,length(t))-0.47;
Sig=s1+s2+noise;

%Frequenzanalyse
df=fa/N;
f=-fa/2:df:fa/2-df;

Sig_fft=fft(Sig)/N;
Sig_fft2=abs(fftshift(Sig_fft));

%Signalrekonstruktion, Gleichanteil löschen, finden der
%Signalfrequenz/Amplitude und Phase
Sig_fftpos=Sig_fft(1:N/2);
Gleichanteil=Sig_fftpos(1);
Sig_fftpos(1)=0;

index=find(abs(Sig_fftpos)>0.1);
f_Sig=abs(Sig_fftpos(index));
Amplituden=2*f_Sig;
Frequenzen=(index-1)*df;
Phase=angle(Sig_fftpos(index));
Sig_rekonstruiert=Gleichanteil+Amplituden*cos(2*pi*Frequenzen.*t'+Phase)';

Nyquistfreq=2*max(Frequenzen);

%Grafiken im Zeitbereich und Frequenzbereich
figure(1), clf
subplot(2,2,1)
plot(t,Sig);
xlabel('t[s]')
ylabel('Sig(n\Deltat)')
title('Zeitbereichssignal')
subplot(2,2,2)
plot(t,Sig_rekonstruiert);
xlabel('t[s]')
ylabel('Sig(n\Deltat)')
title('rekonstruiertes Zeitbereichssignal')
subplot(2,2,[3,4])
stem(f,Sig_fft2,'b^');
xlabel('f[Hz]')
ylabel('|Sig(n\Deltaf|)')
title('Frequenzbereichssignal')
% xlim([-Nyquistfreq*1.3 Nyquistfreq*1.3])
