clc;close;clear;

%1
num1=10;
den1=[1 3 2 0];
g1=tf(num1,den1);           % funcao de transferencia
d1=1;                       % amplitude do rele
Ts1=1;                      % tempo de amostragem
eps1=0;                     % histerese

%2
num2=3;
den2=[2 1];
g2=tf(num2,den2,'io',0.1);  % funcao de transferencia
d2=5;                       % amplitude do rele
Ts2=1;                      % tempo de amostragem
eps2=1;                     % histerese
d0 = 0;
eps0 = 0;

% SIMULACAO SIMULINK
mdl     = "c6problem1simulation";
open_system(mdl)
sim("c6problem1simulation")