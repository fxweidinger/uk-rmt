close all;clc;

%% Constants
laserWavelength=633;
%% Read data
delimiterIn = '\t';
longDistanceMeasure_1 = importdata("interferometry_spectrometry/Interferometrie/Interf/LangeDistanz/1.csv");
longDistanceMeasure_2 = importdata("interferometry_spectrometry/Interferometrie/Interf/LangeDistanz/2.csv");
longDistanceMeasure_3 = importdata("interferometry_spectrometry/Interferometrie/Interf/LangeDistanz/3.csv");
longDistanceMeasure_4 = importdata("interferometry_spectrometry/Interferometrie/Interf/LangeDistanz/5.csv");
longDistanceMeasure_5 = importdata("interferometry_spectrometry/Interferometrie/Interf/LangeDistanz/6.csv");

shortDistanceMeasure_1=importdata("interferometry_spectrometry/Interferometrie/Interf/kurzeDistanz/1.csv");
shortDistanceMeasure_2=importdata("interferometry_spectrometry/Interferometrie/Interf/kurzeDistanz/2.csv");
shortDistanceMeasure_3=importdata("interferometry_spectrometry/Interferometrie/Interf/kurzeDistanz/3.csv");
shortDistanceMeasure_4=importdata("interferometry_spectrometry/Interferometrie/Interf/kurzeDistanz/4.csv");
shortDistanceMeasure_5=importdata("interferometry_spectrometry/Interferometrie/Interf/kurzeDistanz/5.csv");

t=longDistanceMeasure_1.data(1:end,1);
x=longDistanceMeasure_1.data(1:end,2);
t2=longDistanceMeasure_2.data(1:end,1);
x2=longDistanceMeasure_2.data(1:end,2);
t3=longDistanceMeasure_3.data(1:end,1);
x3=longDistanceMeasure_3.data(1:end,2);
t4=longDistanceMeasure_4.data(1:end,1);
x4=longDistanceMeasure_4.data(1:end,2);
t5=longDistanceMeasure_5.data(1:end,1);
x5=longDistanceMeasure_5.data(1:end,2);

ts=shortDistanceMeasure_1.data(1:end,1);
xs=shortDistanceMeasure_1.data(1:end,2);
ts2=shortDistanceMeasure_2.data(1:end,1);
xs2=shortDistanceMeasure_2.data(1:end,2);
ts3=shortDistanceMeasure_3.data(1:end,1);
xs3=shortDistanceMeasure_3.data(1:end,2);
ts4=shortDistanceMeasure_4.data(1:end,1);
xs4=shortDistanceMeasure_4.data(1:end,2);
ts5=shortDistanceMeasure_5.data(1:end,1);
xs5=shortDistanceMeasure_5.data(1:end,2);

%% Maxima und Minima zählen
% figure;
% TF2=islocalmax(x,'MinSeparation',633/2);
% plot(t,x,t(TF2),x(TF2),'r*');
% nnz(x(TF2))
% figure;
% TF2=islocalmax(x2,'MinSeparation',633/2);
% plot(t,x2,t(TF2),x2(TF2),'r*');
% nnz(x3(TF2))
% figure;
% TF2=islocalmax(x3,'MinSeparation',633/2);
% plot(t,x3,t(TF2),x3(TF2),'r*');
% nnz(x3(TF2))
% figure;
% TF2=islocalmax(x4,'MinSeparation',633/2);
% plot(t,x4,t(TF2),x4(TF2),'r*');
% nnz(x4(TF2))
% figure;
% TF2=islocalmax(x5,'MinSeparation',633/2);
% plot(t,x5,t(TF2),x5(TF2),'r*');
% nnz(x5(TF2))
% 
% figure;
% TF2=islocalmax(xs,'MinSeparation',633/2);
% plot(t,xs,t(TF2),xs(TF2),'r*');
% nnz(xs(TF2))
% figure;
% TF2=islocalmax(xs2,'MinSeparation',633/2);
% plot(t,xs2,t(TF2),xs2(TF2),'r*');
% nnz(xs3(TF2))
% figure;
% TF2=islocalmax(xs3,'MinSeparation',633/2);
% plot(t,xs3,t(TF2),xs3(TF2),'r*');
% nnz(xs3(TF2))
% figure;
% TF2=islocalmax(xs4,'MinSeparation',633/2);
% plot(t,xs4,t(TF2),xs4(TF2),'r*');
% nnz(xs4(TF2))
% figure;
% TF2=islocalmax(xs5,'MinSeparation',633/2);
% plot(t,xs5,t(TF2),xs5(TF2),'r*');
% nnz(xs5(TF2))


%% Mittelwertbereinigung
% figure;
% x_mean=x-mean(x);
% plot(t,x_mean);

figure;
signal1=hilbert(xs);
signal2=hilbert(xs2);
signal3=hilbert(xs3);
signal4=hilbert(xs4);
signal5=hilbert(xs5);
calc1=angle(signal1)*633*1e-9/(2*pi);
calc2=angle(signal2)*633*1e-9/(2*pi);
calc3=angle(signal3)*633*1e-9/(2*pi);
calc4=angle(signal4)*633*1e-9/(2*pi);
calc5=angle(signal5)*633*1e-9/(2*pi);


% figure;
% plot(t,x);
% legend('original Signal');
% title('Signal');
% 
% hilbertTransform=hilbert(x,100000);
% hilbertTransform2=hilbert(x2);
% %test=angle(hilbertTransform2)-angle(hilbertTransform)
% figure(1);
% subplot(211);
% plot(abs(hilbertTransform));
% title("Magintude")
% subplot(212);
% hold on;
% plot(t,x);
% plot(angle(hilbertTransform)*180/pi*633/360);
% legend("x","hilbert")
% title("Phase");

%figure;
%plot(t,wrapToPi(unwrap(angle(hilbertTransform))))


% y=hilbert(x);
% plot(t,real(y),t,imag(y))
% legend('real','imaginary')
% title('hilbert Function')
% xlabel('Time (s)')
% 
% origPhase=unwrap(angle(real(y)));
% hilbertPhase = angle(imag(y));
% figure;
% plot(t,origPhase);
% legend('orig','hilb')
% title('hilbert Function')
% xlabel('Time (s)')
% 
% figure;
% TF2=islocalmax(x,'MinSeparation',633/2);
% plot(t,x,t(TF2),x(TF2),'r*');
% nnz(x(TF2))


% figure;
% origPhase=unwrap(angle(x));
% hilbertPhase = unwrap(angle(y));
% plot(t,hilbertPhase,t,x);
% legend('hilbert','orig')
% title('Phasen')
% xlabel('Time (s)')

% origPhase=unwrap(angle(x));
% phase_diff = wrapToPi(origPhase-hilbertPhase);