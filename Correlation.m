clc;
clear;

% Korelacja przy wyznaczaniu modelu liniowego (parametrycznie)
N = 50;
x = linspace(0,1,N)';
y = 2*x+3 + 0.1 * randn(N,1);
figure
plot(x,y,'k.')
hold on;
Y = y;
X = [x ones(N,1)];
A_hat = X\Y;
y_hat1 = X * A_hat;
plot(x,y_hat1,'r--')
% Obliczenie współczynnika Pearsona ze wzoru
R = sqrt(1-sum((y-y_hat1).^2)/sum((y-mean(y)).^2));
[r1,p1] = corr(x,y);
% Dla y_hat z modelu liniowego R = r1

%%
X = [x.^2 ones(N,1)];
A_hat = X\Y;
y_hat2 = X * A_hat;
plot(x,y_hat2,'m--')
R2 = sqrt(1-sum((y-y_hat2).^2)/sum((y-mean(y)).^2));

disp([R R2])
p = Fisher_corr_test(R,R2,N);

% jak słaby wykres to może go na dwie części podzielić
%cftool

% dane mają być o nieznanej funkcji, poszukać bazy danych
% opis danych, procedura logika kroki, działający kod .mfile, dane
% wejściowe w formacie .mat, wnioski/ bez ponownego pisania potwierdzonych
% reguł, np. któryś sobie nie poradził bo...




