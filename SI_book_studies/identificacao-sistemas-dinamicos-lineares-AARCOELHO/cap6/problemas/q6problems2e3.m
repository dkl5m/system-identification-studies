%% 2) e 3)
% 2) Obter as constantes Ku e Tu a partir da figura (6.3). Comparar e
% comentar os valores obtidos.
% 
% Tu = Periodo critico do processo(1 vale ao outro ou 1 cume ao cume)
% Para sistema n simetrico: Tu = Tu1+Tu2
% d = amplitude media do sinal de entrada
% a = amplitude media do sinal de saida
% epsilon = histerese
clear;close all; clc


% (i) rele sem histerese
% periodo critico = 22-8 = 14s
TuSH=14;
d1=1;
a1=0.9;
KuSH=(4*d1)/(pi*a1);


% (ii) rele com histerese
% periodo critico = 28-12 = 16s
TuCH=16;
d2=1;
a2=1.1;
% histerese = saida do processo com - saida do processo sem
% epsilon = 1.1-1.0 = 0.1
epsilon=0.1; 
KuCH=(4*d2)/(pi*sqrt(a2^2-epsilon^2));


% 3) Utilizar os valores de Ku e Tu encontrados da figura (6.3) e,
% considerando o ganho estatico do processo K=1, determinar o modelo de
% primeira ordem com atraso de transporte da equacao (6.3).
% Reles simetricos, so possuem d

% Modelo ordem 1
%   Gp(s)=K*exp(-teta1*s)/(tau1*s+1)
K=1;
s=tf([1 0],1); % Cria tf 's'.

% (i) rele sem histerese
teta01=abs(log((d1*K)/(d1*K+a1))); % atraso de transporte
x1=(d1+d1)*K*exp(teta01)-d1*K;
y1=d1*K;
tau1=TuSH/log(x1/y1); % constante de tempo
% tf rele sem histerese
Gp1=K*exp(-teta01*s)/(tau1*s+1);
Gp1

% (ii) rele com histerese
% teta2=log((d2*K+epsilon)/(a2+d2*K));
% tau2=
epsilon0=0;
teta02=abs(log((d2*K+epsilon0-epsilon)/(d2*K+a2))); % atraso de transporte
x2=(d2+d2)*K*exp(teta02)-d2*K-epsilon0+epsilon;
y2=d2*K-epsilon0-epsilon;
tau2=TuCH/log(x2/y2); % constante de tempo
% tf rele com histerese
Gp2=K*exp(-teta02*s)/(tau2*s+1);
Gp2