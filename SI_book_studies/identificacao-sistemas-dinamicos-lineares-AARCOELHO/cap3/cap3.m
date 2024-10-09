%%
% Exemplo 3.1
% Conversao continua para discreta
% Gp(s)=num(s)/den(s) -> Gp(z)=numz(z)/denz(z)
num=[1]; den=[15 8 1]; Ts=1;
[numz, denz]=c2dm(num,den,Ts,'zoh') % modelo discreto
disp('zeros -> sistema discreto')
zeros=roots(numz)                   % zeros e polos
disp('polos -> sistema discreto')
polos=roots(denz)
dstep(numz, denz)                   % resposta
title('resposta a a sequencia unitaria');
ylabel('saida'), xlabel('amostras)

%%
% Exemplo 3.2
% Geracao ruido branco
% media nula e variancia unitaria
N=100;
x = rand(N,1) % media 0.5 e variancia 0.083
y = 2*x-1; % media nula e variancia 0.33
z = sqrt(3)*y; % media nula e variancia 1
mean(z);var(z);
plot(z);
ylabel('e(t)'), xlabel('amostras')
