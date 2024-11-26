clear; close all; clc;

% Nieliniowa metoda najmniejszych parametrów
x = linspace(0,1,101)';
a = 2;
b = 5;
y = a*cosh(b*x);

figure; plot(x,y,'r','LineWidth',3); grid on;
n = 5*randn(size(x));
yn = y+n;

hold on;
plot(x,yn,'k.');

% Estymator początkowy
Y = yn;
X = [ones(size(x)) x.^2 x.^4 x.^6 x.^8];
A_hat0 = X\Y;
a0 = A_hat0(1);
b0 = sqrt(2*A_hat0(2)/a0);
y_hat0 = a0*cosh(b0*x);
plot(x,y_hat0,'b--','LineWidth',2)
% Granice dolne i górne
LB = [0; -100];
UB = [Inf; 100];

Options = optimset('Display', 'off');
A_hat = lsqnonlin('mycosh', [a0,b0],LB,UB,Options,x,yn);
a0_hat = A_hat(1);
b0_hat = A_hat(2);
y_hat = a0_hat*cosh(b0_hat*x);
plot(x,y_hat,'c-.','LineWidth',2);

