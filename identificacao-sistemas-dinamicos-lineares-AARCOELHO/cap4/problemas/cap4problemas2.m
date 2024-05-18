% Ch4.P4
f=zeros(1,19);
f(1:10)=0.1:0.1:1;
f(11:19)=[1.2 1.5 2 2.5 3 4 5 7 10];

w=2*pi*f;

modG=[7.1 7 6.7 6.4 6 5.6 5.1 ...
    4.6 4.1 3.7 2.7 1.4 -0.6 -2.3 -3.7 -6 ...
    -7.9 -10.8 -13.8];

phaseG=[-6.35 -12.6 -18.5 -24.1 -29.2 -33.8 -38 ...
    -41.8 -45.1 -48.1 -53.3 -59.1 -65.9 -70.3 -73.4 -77.4 ...
    -79.8 -82.7 -84.9];


figure(1)

subplot 211
semilogx(w,modG);
grid;
xlabel ('Frequência (rad/s)'); % Adiciona rótulo do eixo x.
ylabel ('Ganho (dB)');
title ('Resposta em frequência');


subplot 212
semilogx(w,phaseG)
grid;
xlabel ('Frequência (rad/s)'); % Adiciona rótulo do eixo x.
ylabel ('Fase (graus)');


% Com base nos gráficos estima-se o modelo:

G=tf(2.2646,[0.1876 1]);

figure (2)
bode(G,w);
grid;


%% Ch4.p5

w=zeros(1,14);
w(1:5)=0.1:0.1:0.5;
w(6:14)=[0.7 1 10 15 20 30 40 50 100];


modG=[0.32 1.1 2.04 2.93 3.72 4.96 6.15 ...
    -25.81 -32.91 -37.92 -44.98 -49.98 -53.86 -65.9];

phaseG=[4.90 7.43 7.01 4.33 0.16 -10.77 -31.25 ...
    -168.51 -172.66 -174.51 -176.35 -177.26 -177.81 -178.9];

figure(1)

subplot 211
semilogx(w,modG);
grid;
xlabel ('Frequência (rad/s)');
ylabel ('Ganho (dB)')
title ('Resposta em frequência Experimental');

subplot 212
semilogx(w,phaseG);
grid;
xlabel ('Frequência (rad/s)'); 
ylabel ('Fase (graus)');

%Gp=tf(1.04*[1 1],conv([1 0.51 1],[0.1 1]));
Gp1=tf(1.04,[1 0.51 1]);

[M1,P1]=bode(Gp1,w); % Gera os dados de Bode para Gp1(s).
M2=modG-20*log10(M1(:,:));

P2=phaseG-P1(:,:);

figure (2)

subplot 211
semilogx(w,M2);
grid;
xlabel ('Frequência (rad/s)');
ylabel ('Ganho (dB)')
% title ('Resposta em frequência Experimental menos G1(s)=\frac{1.04}{s^2+0.51s+1}');

subplot 212
semilogx(w,P2);
grid;
xlabel ('Frequência (rad/s)'); 
ylabel ('Fase (graus)');

Gp2=tf([1 1],1);

[M3,P3]=bode(Gp2,w); % Gera os dados de Bode para Gp2(s).
M4=M2-20*log10(M3(:,:));
P4=P2-P3(:,:);

figure (3)

subplot 211
semilogx(w,M4);
grid;
xlabel ('Frequência (rad/s)');
ylabel ('Ganho (dB)')
title ('Resposta em frequência');

subplot 212
semilogx(w,P4);
grid;
xlabel ('Frequência (rad/s)'); 
ylabel ('Fase (graus)');

Gp3=tf(1,[1/10 1]);

[M5,P5]=bode(Gp3,w); % Gera os dados de Bode para Gp3(s).
M6=M4-20*log10(M5(:,:));
P6=P4-P5(:,:);

figure (4)

subplot 211
semilogx(w,M6);
grid;
xlabel ('Frequência (rad/s)');
ylabel ('Ganho (dB)')
title ('Resposta em frequência');

subplot 212
semilogx(w,P6);
grid;
xlabel ('Frequência (rad/s)'); 
ylabel ('Fase (graus)');


%% Ch4.P6

% Especificações de desempenho:

tp=25*10^(-3);
yss=2.85;

% Manipulando as fórmulas:

zeta=1/sqrt(1+(pi/log(5))^2);      % sobressinal de 20%
%zeta=0.46;
wn=pi/(tp*sqrt(1-zeta^2));

% Modelo:

K=yss;
num=K*wn^2;
den=[1 2*zeta*wn wn^2];
G=tf(num,den);

step(G);
grid;


%% Ch4.P7

% Amostras de resposta ao impulso
% do sistema de segunda ordem:

h=[0 0.68 1.07 1.27 1.34 1.33 1.28 1.21 1.11];

A=[h(2) h(3);h(3) h(4)]\[-h(4);-h(5)];

B=[1 0 0;A(2) 1 0;A(1) A(2) 1]*[h(1);h(2);h(3)];

num=B';
den=[1 A(2:-1:1)'];

Gpz_1=tf(num,den,0.05,'Variable','z^-1');

Gp=d2c(Gpz_1,'zoh');

step(Gpz_1,Gp);


%% Ch4.P8
% Especificações de desempenho:

PO=0.05;
tp=1.2;
yss=1;

% Manipulando as fórmulas:

zeta=1/sqrt(1+(pi/log(PO))^2);

wn=pi/(tp*sqrt(1-zeta^2));

% i)
% Modelo de segunda ordem estimado:

num=wn^2;
den=[1 2*zeta*wn wn^2];

Gmf=tf(num,den);

step(Gmf);
grid;

% ii)

% iii)

np=13.09/0.5;
dp=[1 2*zeta*wn 0];

Gp=tf(np,dp);

t=0:.01:40;
u=zeros(1,4001);
u(1:1001)=1;

lsim(Gp,u,t);
grid;
title('Resposta ao pulso unitário sistema em malha aberta');
xlabel('tempo');
ylabel('saída');