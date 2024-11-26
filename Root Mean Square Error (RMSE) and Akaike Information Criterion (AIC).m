close all;
clc

%% Generacja danych
a0 = 3;
a1 = 5;
a2 = -0.5;
x = (0:0.1:10)';
y = a0 + a1*x + a2*x.^2;
n = 2 * randn(size(x));     % randN- szum gausowski normalny, standardowy (-3:3)
yn = y + n;                % szum adyktywny

figure
plot(x,yn,'*k');
grid on;

N = length(x);
Pmax = 11;
RMS = zeros(Pmax,1); % Root-Mean-Square
PF = zeros(Pmax,1); % Penalty Function
AIC = zeros(Pmax,1); % Information Criterion
for p = 1 :Pmax
    [Y_hat, A_hat] = linearLS(x,yn,p);
    RMS(p) = sqrt(mean((yn-Y_hat).^2));
    PF(p) = 6 * (p+1)/N; % penalty in Akaike Information Criterion
    AIC(p) = RMS(p) + PF(p);
end

figure
plot(1:Pmax,RMS,'-*'); hold on; grid on;
plot(1:Pmax,AIC,'k--')

[~,ind] = min(AIC);
title(['Optional order = ' num2str(ind)])



