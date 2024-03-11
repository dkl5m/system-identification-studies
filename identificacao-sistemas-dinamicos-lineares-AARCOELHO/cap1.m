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

%{
Ex1.2-Estimador parametro planta
equacao;
%}
y(1)=0; u(1)=0; soma1=0; soma2=0;
for i=2:30
    u(i)=1; y(i)=0.9*y(i-1)+u(i-1);
end
for k=1:30
    soma1=soma1+y(k)*(y(k+1)-u(k));
    soma2=soma2+y(k)^2;
end
t=1:30
plot(t,teta(t));
