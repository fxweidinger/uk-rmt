clear all;
load('Fourier_v_f.mat')
%relevante Parameter der Frequenzanalyse, Abtastzeit/-frequenz, Anzahl
%Abtastwerte, Frequenzachse in Hz
dt=zeit(2)-zeit(1);
fa=1/dt;
N=length(signal);
df=fa/N;
f=-fa/2:df:fa/2-df;
%Fast Fourier-Transformation (FFT)
Signal_fft=fft(signal)/N;
Signal_fft2=abs(fftshift(Signal_fft));

Sig_fftpos=Signal_fft(1:N/2);
Gleichanteil=Sig_fftpos(1);
Sig_fftpos(1)=0;

index=find(abs(Sig_fftpos)>0.1);
f_Sig=abs(Sig_fftpos(index));
Amplituden=2*f_Sig;
Frequenzen=(index-1)*df;
Phase=angle(Sig_fftpos(index));
Sig_rekonstruiert=Gleichanteil+Amplituden*cos(2*pi*Frequenzen.*zeit'+Phase)';

Nyquistfreq=2*max(Frequenzen);

%Grafiken im Zeitbereich und Frequenzbereich
figure(1), clf
subplot(2,2,1)
plot(zeit,signal);
xlabel('t[s]')
ylabel('Sig(n\Deltat)')
title('Zeitbereichssignal')
subplot(2,2,2)
plot(zeit,Sig_rekonstruiert);
xlabel('t[s]')
ylabel('Sig(n\Deltat)')
title('rekonstruiertes Zeitbereichssignal')
subplot(2,2,[3,4])
stem(f,Signal_fft2,'b^');
xlabel('f[Hz]')
ylabel('|Sig(n\Deltaf|)')
title('Frequenzbereichssignal')
