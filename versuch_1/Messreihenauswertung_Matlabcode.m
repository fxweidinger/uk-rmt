clear all;
%Signalauswertung Messreihen
load('12kmh10ohm.fig','-mat');

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

% Hilbert-Trafo
N_Felge=length(X_Felge)-40000;
N_Achse=length(X_Achse)-40000;
dt=1e-4;
t_Felge=0:dt:(N_Felge*dt)-dt;
t_Achse=0:dt:(N_Achse*dt)-dt;
fs=1/dt; %ganzzahliges vielfaches einer Periode abtasten, 2sec
df=1/(N_Achse*dt);
f_xaxis=-fs/2:df:fs/2-df;

%Hilbert vom Felgensignal bei Last
hilb_LSF=hilbert(Y_Felg-mean(Y_Felg),N_Felge);%Analytische Signal mit Mittelung über ganzen Messablauf
phiFelge=angle(hilb_LSF)*180/pi; %Verlauf des Phasenwinkels phiFelge
phase_all_Felge=unwrap(angle(hilb_LSF))*180/pi; %phasen aneineinandergehängt

%Hilbert vom Achsensignal bei Last
hilb_LSA=hilbert(Y_Ach-mean(Y_Ach),N_Achse);
phiAchse=angle(hilb_LSA)*180/pi;
phase_all_Achse=unwrap(angle(hilb_LSA))*180/pi;
% p2=polyfit(t_Achse,phase_all_Achse,1);
% Signalfrequenz_Achse=p2(1,1);


%Berechnung des unbelasteten Phi
Phi_belastet=mean(phase_all_Felge(1:end)-phase_all_Achse(1:end));
Phi_belastet_Betrag_Mittelwert=abs(Phi_belastet);
KON=89.5863;
phiTorsion=abs(KON-Phi_belastet_Betrag_Mittelwert);
M=(phiTorsion*300)/36;
%Plotten Felge und Achse
figure(1);
subplot(2,1,1);
plot(t_Felge,phase_all_Felge);
xlabel('Zeit in Sekunden');
ylabel('Phase unwrapped in Grad');
hold on;
plot(t_Achse,phase_all_Achse);
legend('Phase unwrapped Felge','Phase unwrapped Achse');
title(['|\Delta\phi_{belastet}|=',num2str(Phi_belastet_Betrag_Mittelwert), '\circ']);

subplot(2,1,2);
plot(t_Felge,phiFelge);
xlabel('Zeit in Sekunden');
ylabel('Phase in Grad');
legend('Phasenverlauf Felge');
hold on;
plot(t_Achse,phiAchse);
legend('Phasenverlauf Felge','Phasenverlauf Achse');



figure(2);
subplot(2,2,1);
plot(X_Felge,Y_Felge);
xlabel('Zeit in Sekunden');
ylabel('Ampl. ADC-Werte');
hold on;
plot(X_Achse,Y_Achse);
legend('Signal Felge Last','Signal Achse Last');
subplot(2,2,3);
plot(X_Achse,Y_Achse);
xlabel('Zeit in Sekunden');
ylabel('Ampl. ADC-Werte');
legend('Signal Achse Leerlauf');
subplot(2,2,2);
plot(t_Felge,real(hilb_LSF));
xlabel('Zeit in Sekunden');
ylabel('Amplidude');
hold on;
plot(t_Felge,imag(hilb_LSF));
legend('Realteil Felge','Imaginärteil Felge');
subplot(2,2,4);
plot(t_Achse,real(hilb_LSA));
xlabel('Zeit in Sekunden');
ylabel('Amplidude');
hold on;
plot(t_Achse,imag(hilb_LSA));
legend('Realteil Felge','Imaginärteil Felge');