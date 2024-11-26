clear; close all; clc;

% Nieliniowa metoda najmniejszych parametrów
x = linspace(0,1,101)';
a = 2;
b = -4;
y = a*exp(b*x);

figure; plot(x,y,'r','LineWidth',3); grid on;
n = 0.1*randn(size(x));
yn = y+n;
hold on;
plot(x,yn,'k.');
ind_non_zero = yn > 0;

% Estymator początkowy
%Y = log(ind_non_zero);
%X = [ones(sum(ind_non_zero),1) x(ind_non_zero)];
% X = [ones(size(x)) x x.^2 x.^3 x.^4];
%A_hat0 = X\Y;
%a0 = exp(A_hat0(1));
%b0 = A_hat0(2)/a0;
%y_hat0 = a0*exp(b0*x);
%plot(x,y_hat0,'b--','LineWidth',2)
% Granice dolne i górne
%LB = [Inf; 0];
%UB = [0; -100];

%Options = optimset('Display', 'off');
%A_hat = lsqnonlin('myexp', [a0,b0],LB,UB,Options,x,yn);
%a0_hat = A_hat(1);
%b0_hat = A_hat(2);
%y_hat = a0_hat*exp(b0_hat*x);
%plot(x,y_hat,'c-.','LineWidth',2);

Y = log(yn(ind_non_zero));
X = [ones(sum(ind_non_zero),1) x(ind_non_zero)];
A = X\Y;
a_hat = exp(A(1));
b_hat = A(2);
y_hat = a_hat*exp(b_hat*x);

disp([a_hat b_hat])



