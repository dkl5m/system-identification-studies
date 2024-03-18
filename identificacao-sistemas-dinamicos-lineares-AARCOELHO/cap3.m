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
