% metoda najmniejszych kwadratów (LS)
% pseudo odwrotność macierzy

% Przykład dopasowania danych metodą najmniejszych kwadratów (LS)
clear;
close all;
clc;

%% Generacja danych
a0 = 3;
a1 = 5;
a2 = -1.5;
x = (0:0.1:10)';
y = a0 + a1*x + a2*x.^2;
n = 6 * randn(size(x));     % randN- szum gausowski normalny, standardowy (-3:3)
yn = y + n;                 % szum adyktywny

figure; plot(x,yn,'*k'); grid on;

Pmax = 11;
SSE = zeros(Pmax,1);
for p = 1:1:Pmax
    [Y_hat, A_hat] = linearLS(x,yn,p);
    SSE(p) = sum((yn-Y_hat).^2);
    display(A_hat')
end
% N>>P_max

%%%%%%%%%%%%%%%%%%%%%%%%%
% Wyznaczyć P_optymalne %
%%%%%%%%%%%%%%%%%%%%%%%%%

figure
plot(1:Pmax,SSE,'*-')
grid on;


