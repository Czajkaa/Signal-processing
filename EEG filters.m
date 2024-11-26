clear;
close all;
clc;

%% Dane wejściowe
load("s01.mat");
eeg_signal = eeg.movement_right(67,:);                                      
% Wybór sygnału z danego czujnika
fs = 1000;                                                                  
% Częstotliwość próbkowania
t = (0:1/fs:(length(eeg_signal)-1/fs)/fs);                                  
% Czas próbkowania

% Wyświetlanie wyników
figure
sgtitle('Wejściowy sygnał EEG')
subplot(2,1,1),
plot(t, eeg_signal), grid on;
title('Cały sygnał EEG')
xlabel('Czas (s)');
ylabel('Amplituda');
subplot(2,1,2),
plot(t, eeg_signal), grid on;
title('Fragment sygnału EEG')
xlabel('Czas (s)');
ylabel('Amplituda');
xlim([3 4])

%% Filtr dolnoprzepustowy
LPF_CF = 30;                                                                
% Częstotliwość odcięcia w Hz
LPF_NF = fs/2;                                                              
% Połowa częstotliwości próbkowania sygnału
LPF_FO = 4;                                                                 
% Stopień wielomianu filtra

[LPF_b, LPF_a] = butter(LPF_FO, LPF_CF/LPF_NF, 'low');                      
% Projektowanie filtra dolnoprzepustowego
LPF_eeg_signal = filtfilt(LPF_b, LPF_a, eeg_signal);                        
% Filtrowanie sygnału EEG

% Wyświetlanie wyników
figure;
sgtitle('Filtrowanie dolnoprzepustowe - cały zakres')
subplot(2,1,1),
plot(t, eeg_signal), grid on;
title('Sygnał EEG przed filtrowaniem');
xlabel('Czas (s)');
ylabel('Amplituda');
subplot(2,1,2);
plot(t, LPF_eeg_signal), grid on;
title('Sygnał EEG po filtrowaniu dolnoprzepustowym');
xlabel('Czas (s)');
ylabel('Amplituda');

figure;
sgtitle('Filtrowanie dolnoprzepustowe - dany fragment')
subplot(2,1,1),
plot(t, eeg_signal), grid on;
title('Sygnał EEG przed filtrowaniem');
xlabel('Czas (s)');
ylabel('Amplituda');
xlim([3 4])
subplot(2,1,2),
plot(t, LPF_eeg_signal); grid on;
title('Sygnał EEG po filtrowaniu dolnoprzepustowym');
xlabel('Czas (s)');
ylabel('Amplituda');
xlim([3 4])

%% Usunięcie baseline
WBS_eeg_signal = eeg_signal - LPF_eeg_signal;                               
% Usunięcie baseline

% Wyświetlanie wyników
figure;
sgtitle('Usuwanie baseline - cały zakres')
subplot(2,1,1),
plot(t, eeg_signal), grid on;
title('Sygnał EEG przed usunięciem');
xlabel('Czas (s)');
ylabel('Amplituda');
subplot(2,1,2),
plot(t, WBS_eeg_signal); grid on;
title('Sygnał EEG po usunięciu');
xlabel('Czas (s)');
ylabel('Amplituda');

figure;
sgtitle('Usuwanie baseline - dany fragment')
subplot(2,1,1),
plot(t, eeg_signal), grid on;
title('Sygnał EEG przed usunięciem');
xlabel('Czas (s)');
ylabel('Amplituda');
xlim([3 4])
subplot(2,1,2),
plot(t, WBS_eeg_signal); grid on;
title('Sygnał EEG po usunięciu');
xlabel('Czas (s)');
ylabel('Amplituda');
xlim([3 4])


