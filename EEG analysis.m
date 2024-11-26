clear;
close all;
clc;

load('s01_2.mat');

%% Analiza średniej mocy w różnych pasmach częstotliwości
fs = 1000;  % Częstotliwość próbkowania (Hz)
nfft = 2^nextpow2(length(eeg_signal));  % Wybór mocy 2 dla poprawy efektywności FFT
frequencies = (0:nfft-1)*(fs/nfft);
fft_result = fft(eeg_signal, nfft);
power_spectrum = abs(fft_result).^2 / length(eeg_signal);

% Wybór pasm częstotliwościowych
delta_band = [1, 4];
theta_band = [4, 8];
alpha_band = [8, 13];
beta_band = [13, 30];
gamma_band = [30, 40];

% Obliczenie średnich mocy dla każdego pasma
delta_power = mean(power_spectrum(frequencies >= delta_band(1) & frequencies <= delta_band(2)));
theta_power = mean(power_spectrum(frequencies >= theta_band(1) & frequencies <= theta_band(2)));
alpha_power = mean(power_spectrum(frequencies >= alpha_band(1) & frequencies <= alpha_band(2)));
beta_power = mean(power_spectrum(frequencies >= beta_band(1) & frequencies <= beta_band(2)));
gamma_power = mean(power_spectrum(frequencies >= gamma_band(1) & frequencies <= gamma_band(2)));

figure;
subplot(2,1,1), plot(t, eeg_signal); grid on;
title('Wykres Czasowy Sygnału EEG');
xlabel('Czas (s)');
ylabel('Amplituda');
subplot(2,1,2), bar([delta_power, theta_power, alpha_power, beta_power, gamma_power]); grid on;
title('Średnie Moce w Pasmach Częstotliwościowych');
xticklabels({'Delta', 'Theta', 'Alpha', 'Beta', 'Gamma'});
ylabel('Średnia Moc');

%% Macierz korelacji
% Macierz korelacji między elektrodami
correlation_matrix = corr(eeg_data(:,1:10)');
correlation_matrix_full = corr(eeg_data');

figure;
imagesc(correlation_matrix);
colorbar;
title('Macierz korelacji między elektrodami');
xlabel('Elektroda');
ylabel('Elektroda');

figure;
imagesc(correlation_matrix_full);
colorbar;
title('Macierz korelacji między elektrodami');
xlabel('Elektroda');
ylabel('Elektroda');

