%{
Coelho-cap1
Ex1.1-Sistema massa-mola-amortecedor
massa(m);coeficiente-atrito(b);
constante-mola(k);
%}

% para b=4Nseg/m
m=2;b=4;k=12;
num=1; den=[m b k];
printsys(num, den, 's');
figure;
step(num, den);
roots(den);

% para b=10Nseg/m
b1=10;
den1=[m b1 k];
figure;
printsys(num, den1, 's');
step(num, den1);

