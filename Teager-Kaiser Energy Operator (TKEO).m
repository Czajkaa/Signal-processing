clear;
close all;
clc;

%% Dane
load("Dane.mat");
F = 2000;                                                                   % Częstotliwość próbkowania w Hz
T = 1/F;                                                                    % Okres próbkowania
len_data = length(data(:,1));                                               % Ilość próbek
x = (0:len_data-1)*T;                                                       % Długość pomiaru
y = data(:,1);                                                              % Dane

%% Operator Energetyczny Teagera-Kaisera
y_TKEO = y;                                                                 % Dane do obliczenia TKEO
for n=2:length(y)-1
    y_TKEO(n) = y(n)^2 - y(n-1)*y(n+1);                                     % Obliczenie wartości według wzoru
end

figure
sgtitle('Zestawienie wykresów znormalizowanych')
% Pierwszy wykres
subplot(3,1,1),
plot(x,y./max(y), "Color", 'b'); grid on;
xlabel('Czas [s]'),
ylabel('Napięcie [mV]')
title('Surowy sygnał')
legend({'EMG'})
% Drugi wykres
subplot(3,1,2),
plot(x,y_TKEO./max(y_TKEO), "Color", 'r'), grid on;
xlabel('Czas [s]'),
ylabel('Energia')
title('Sygnał po TKEO')
legend({'EMG (TKEO)'})
% Trzeci wykres
subplot(3,1,3),
plot(x,y./max(y), "Color", 'b'); hold on; grid on;
plot(x,y_TKEO./max(y_TKEO), "Color", 'r')
xlabel('Czas [s]'),
ylabel('Napięcie [mV] / Energia')
title('Nałożony sygnał TKEO na sygnał surowy')
legend({'EMG';'EMG (TKEO)'})

%% Analiza EMG dla surowych danych
f = (0:1/(len_data-1):1)*F;                                                 % Wektor częstotliwości

% Filtr górnoprzepustowy (HPF)
N_HPF = 3000;                                                               % Rząd filtru
CF = 40;                                                                    % Częstotliwość graniczna
HPF = fir1(N_HPF,CF/(F/2));                                                 % Obliczanie współczynników filtra HPF
y_HPF = filter(HPF,1,y);                                                    % Sygnał po zastosowaniu filtra

% Filtr średniej arytmetycznej
N_AM = 1000;                                                                % Rząd filtra
AM = ones(1,N_AM+1);  
y_AM = sqrt(filter(AM,1,y_HPF.^2) / (N_AM+1));                              % Sygnał z zastosowanym filtrem średniej arytmetycznej

% Filtr Butterwortha
BF = designfilt('bandstopiir','FilterOrder',2, ...                          % Filtr Butterwortha
    'HalfPowerFrequency1',49,'HalfPowerFrequency2',51, ...
    'DesignMethod','butter','SampleRate',F);
fvtool(BF,'Fs',F);                                                          % Charakterystyka filtru Butterwortha                                                    
y_BF = filtfilt(BF,y);                                                      % Sygnał z zastosowanym filtrem Butterwortha
grpdelay(BF,N_HPF,F)                                                        % Wizualizacja opóźnienia filtru Butterwortha
delay = mean(grpdelay(BF));                                                 % Opóźnienie filtru Butterwortha

figure;
sgtitle('Analiza sygnału EMG')
% Pierwszy wykres
subplot(2,1,1),
plot(x,y./max(y)); hold on; grid on;
plot(x,y_BF./max(y_BF));
plot(x,y_AM,'k','LineWidth',2);
plot(x,-y_AM,'k','LineWidth',2);
title('Surowy sygnał po analizie (HPF, średniej arytmetycznej, Butterwortha)')
xlabel('Czas [s]')
ylabel('Amplituda')
xlim([0 65])
legend({'Surowy';'Butterworth';'Wykrywanie skurczu'})
% Drugi wykres
subplot(2,1,2),
plot(x,y./max(y)); hold on; grid on;
plot(x,y_BF./max(y_BF));
plot(x-delay,y_AM,'k','LineWidth',2);
plot(x-delay,-y_AM,'k','LineWidth',2);
title('Surowy sygnał po analizie z korektą opóźnienia (HPF, średniej arytmetycznej, Butterwortha)')
xlabel('Czas [s]')
ylabel('Amplituda');
xlim([0 65])
legend({'Surowy';'Butterworth';'Wykrywanie skurczu'})

%% Analiza EMG dla danych TKEO
y_TKEO_HPF = filter(HPF,1,y_TKEO);                                          % Filtr górnoprzepustowy dla TKEO
y_TKEO_AM = sqrt(filter(AM,1,y_TKEO_HPF.^2) / (N_AM+1));                    % Filtr średniej arytmetycznej
y_TKEO_BF = filtfilt(BF,y_TKEO);                                            % Filtr Butterwortha

figure;
% Pierwszy wykres
subplot(2,1,1),
plot(x,y); hold on; grid on;
plot(x,y_BF);
plot(x-delay,y_AM,'k','LineWidth',2);
plot(x-delay,-y_AM,'k','LineWidth',2);
title('Surowy sygnał po analizie z korektą opóźnienia (HPF, średniej arytmetycznej, Butterwortha)')
xlabel('Czas [s]')
ylabel('Amplituda');
xlim([0 65])
legend({'Surowy';'Butterworth';'Wykrywanie skurczu'})
% Drugi wykres
subplot(2,1,2),
plot(x,y_TKEO); hold on; grid on;
plot(x,y_TKEO_BF);
plot(x-delay,y_TKEO_AM,'k','LineWidth',2);
plot(x-delay,-y_TKEO_AM,'k','LineWidth',2);
title('Sygnał z zastosowanym TKEO po analizie z korektą opóźnienia (HPF, średniej arytmetycznej, Butterwortha)')
xlabel('Czas [s]')
ylabel('Amplituda');
xlim([0 65])
legend({'Surowy';'Butterworth';'Wykrywanie skurczu'})

figure
plot(x-delay,y_AM,'b','LineWidth',2); hold on; grid on;
plot(x-delay,y_TKEO_AM,'r','LineWidth',2);
plot(x-delay,-y_AM,'b','LineWidth',2);
plot(x-delay,-y_TKEO_AM,'r','LineWidth',2);
xlabel('Czas [s]')
ylabel('Amplituda');
xlim([0 65])
legend({'Surowy';'TKEO'})