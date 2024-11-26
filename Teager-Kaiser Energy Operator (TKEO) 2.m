%% Wczytanie danych
clear;
close all;
clc;

load('Dane2.mat');

%% Analiza czasowo-częstotliwościowa (przy użyciu transformacji falkowej)
[cwt_coefficients, frequencies] = cwt(y, F);
[cwt_coefficients_TKEO, frequencies_TKEO] = cwt(y_TKEO, F);

figure;
subplot(2,1,1);
plot(time, y); grid on;
title('Sygnał EMG');
xlabel('Czas (s)');
ylabel('Amplituda');
subplot(2,1,2);
imagesc(time, frequencies, abs(cwt_coefficients));
title('Transformata falkowa - Analiza czasowo-częstotliwościowa');
xlabel('Czas (s)');
ylabel('Częstotliwość (Hz)');
colorbar;

figure;
subplot(2,1,1);
plot(time, y_TKEO); grid on;
title('Sygnał EMG TKEO');
xlabel('Czas (s)');
ylabel('Amplituda');
subplot(2,1,2);
imagesc(time, frequencies_TKEO, abs(cwt_coefficients_TKEO));
title('Transformata falkowa - Analiza czasowo-częstotliwościowa');
xlabel('Czas (s)');
ylabel('Częstotliwość (Hz)');
colorbar;

%% Analiza czasowo-częstotliwościowa (przy użyciu transformacji Fouriera)
N = length(y);
frequencies = (0:N-1) * F / N;                                              % Wektor częstotliwości
fft_raw = fft(y, N);                                                        % Transformata Fouriera
fft_TKEO = fft(y_TKEO, N);                                                  % Transformata Fouriera

% Jednostronna amplituda
amplitude = abs(fft_raw / N);
amplitude_TKEO = abs(fft_TKEO / N);

% Tylko jedna połowa widma (ponieważ druga połowa jest symetryczna)
amplitude = amplitude(1:N/2+1);
amplitude_TKEO = amplitude_TKEO(1:N/2+1);
frequencies = frequencies(1:N/2+1);

figure;
subplot(2,1,1);
plot(time, y); grid on;
title('Sygnał EMG');
xlabel('Czas (s)');
ylabel('Amplituda');
subplot(2,1,2);
plot(frequencies, amplitude); grid on;
title('Transformata Fouriera - Widmo amplitudowe');
xlabel('Częstotliwość (Hz)');
ylabel('Amplituda');

figure;
subplot(2,1,1);
plot(time, y_TKEO); grid on;
title('Sygnał EMG');
xlabel('Czas (s)');
ylabel('Amplituda');
subplot(2,1,2);
plot(frequencies, amplitude_TKEO); grid on;
title('Transformata Fouriera - Widmo amplitudowe');
xlabel('Częstotliwość (Hz)');
ylabel('Amplituda');

%% Analiza czasowo-częstotliwościowa (przy użyciu spektrum czasowo-częstotliwościowego)
% Parametry analizy czasowo-częstotliwościowej
window_size = 256;                                                          % rozmiar okna
overlap = window_size / 2;                                                  % nakładanie się okien

% Analiza spektrum czasowo-częstotliwościowego
[s_raw, f_raw, time_raw] = spectrogram(y, window_size, overlap, [], F);
[s_TKEO, f_TKEO, time_TKEO] = spectrogram(y_TKEO, window_size, overlap, [], F);

figure;
subplot(2,1,1);
surf(time_raw, f_raw, 10*log10(abs(s_raw)), 'EdgeColor', 'none');
title('Spektrum Czasowo-Częstotliwościowe surowego sygnału');
xlabel('Czas (s)');
ylabel('Częstotliwość (Hz)');
zlabel('Amplituda (dB)');
view(2)
subplot(2,1,2);
surf(time_TKEO, f_TKEO, 10*log10(abs(s_TKEO)), 'EdgeColor', 'none');
title('Spektrum Czasowo-Częstotliwościowe sygnału TKEO');
xlabel('Czas (s)');
ylabel('Częstotliwość (Hz)');
zlabel('Amplituda (dB)');
view(2)
