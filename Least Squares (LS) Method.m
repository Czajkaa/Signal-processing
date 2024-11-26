% metoda najmniejszych kwadratów (LS)
% pseudo odwrotność macierzy

% Przykład dopasowania danych metodą najmniejszych kwadratów (LS)
%% Generacja danych
a0 = 3;
a1 = 5;
a2 = -1.5;
x = (0:0.1:10)';
y = a0 + a1*x + a2*x.^2;
n = 3 * randn(size(x));     % randN- szum gausowski normalny, standardowy (-3:3)
y_n = y + n;                % szum adyktywny

figure
plot(x,y_n,'*k');
grid on;

%% Estymacja parametrów modelu
Y = y_n;
X = [ones(size(x)) x x.^2];
A_hat = X\Y;                % <=> A_hat = (X'*X)^(-1)*X'*Y;

% a0_hat = A_hat(1);
% a1_hat = A_hat(2);

Y_hat = X*A_hat;
hold on;
plot(x,Y_hat, 'r-');

