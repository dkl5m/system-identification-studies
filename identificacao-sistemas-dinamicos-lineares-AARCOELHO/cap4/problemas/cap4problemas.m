% Ch4P1 (Processo 1)

% Estimar modelos de primeira ordem para
% os seguintes processos:

% Gp=tf(1,[1 3 3 1],'io',4);     
% 
% % Saída:
% 
% [y,t] = step(Gp);

dt=t(2)-t(1);

K=y(end)-y(1);

i=input('Escolha:1-Z/N e Hag,2-Smith,3-Sundaresan,4-Nishikawa:');

switch i
    
    case {1}

% Determinar reta tangente de máxima
% inclinação:

[m,I] = max(diff(y)/dt);


yt=y(I)+m*(t-t(I));

% Modelo Z/N e Hag processo 

[~,i1]=min(abs(yt));
[~,i2]=min(abs(0.632*y(end)-y));
[~,i3]=min(abs(y(end)-yt));
t1=t(i1);
t2=t(i2);
t3=t(i3);

teta=t1;
tal_zn=t3-t1;
tal_hag=t2-t1;

Gp_zn=tf(K,[tal_zn 1],'io',teta);
Gp_hag=tf(K,[tal_hag 1],'io',teta);

figure (1)
step(Gp,Gp_zn,Gp_hag);
legend('Processo','Modelo Z/N','Modelo Hag');

case {2}

% Modelo Smith processo   
    
[~,i1]=min(abs(0.283*y(end)-y));    
[~,i2]=min(abs(0.632*y(end)-y));

t1=t(i1);
t2=t(i2);

tal_s=1.5*(t2-t1);
teta=t2-tal_s;

Gp_s=tf(K,[tal_s 1],'io',teta);

figure (1)
step(Gp,Gp_s);
legend('Processo','Modelo Smith');

case {3}
    
  % Modelo Sundaresan processo   
    
[~,i1]=min(abs(0.353*y(end)-y));    
[~,i2]=min(abs(0.853*y(end)-y));

t1=t(i1);
t2=t(i2);

tal_sun=0.67*(t2-t1);
teta=1.3*t1-0.29*t2;

Gp_sun=tf(K,[tal_sun 1],'io',teta);

figure (1)
step(Gp,Gp_sun);
legend('Processo','Modelo Sundaresan');  

    case {4}
        
        % Modelo Nishikawa processo   
        
A0=sum(y(end)-y)*dt;
t0=A0/y(end);
[~,I0]=min(abs(t0-t));
A1=sum(y(1:I0))*dt;

tal_n=A1/(0.368*y(end));
teta=t(I0)-tal_n;

Gp_n=tf(K,[tal_n 1],'io',teta);

figure (1)
step(Gp,Gp_n);
legend('Processo','Modelo Nishikawa');

    otherwise
    
disp('Escolha um método válido!');
    
end

%% Ch4.P1 (Processo 2)

% Estimar modelos de primeira ordem para
% o seguinte processo:
 
d=conv([1 4 6 4 1],[1 4 6 4 1]);
Gp=tf(1,d);

% Saída:

[y,t] = step(Gp);

dt=t(2)-t(1);

K=y(end)-y(1);

i=input('Escolha:1-Z/N e Hag,2-Smith,3-Sundaresan,4-Nishikawa:');

switch i
    
    case {1}

% Determinar reta tangente de máxima
% inclinação:

[m,I] = max(diff(y)/dt);


yt=y(I)+m*(t-t(I));

% Modelo Z/N e Hag processo 

[~,i1]=min(abs(yt));
[~,i2]=min(abs(0.632*y(end)-y));
[~,i3]=min(abs(y(end)-yt));
t1=t(i1);
t2=t(i2);
t3=t(i3);

teta=t1;
tal_zn=t3-t1;
tal_hag=t2-t1;

Gp_zn=tf(K,[tal_zn 1],'io',teta);
Gp_hag=tf(K,[tal_hag 1],'io',teta);

figure (1)
step(Gp,Gp_zn,Gp_hag);
legend('Processo','Modelo Z/N','Modelo Hag');

case {2}

% Modelo Smith processo   
    
[~,i1]=min(abs(0.283*y(end)-y));    
[~,i2]=min(abs(0.632*y(end)-y));

t1=t(i1);
t2=t(i2);

tal_s=1.5*(t2-t1);
teta=t2-tal_s;

Gp_s=tf(K,[tal_s 1],'io',teta);

figure (1)
step(Gp,Gp_s);
legend('Processo','Modelo Smith');

case {3}
    
  % Modelo Sundaresan processo   
    
[~,i1]=min(abs(0.353*y(end)-y));    
[~,i2]=min(abs(0.853*y(end)-y));

t1=t(i1);
t2=t(i2);

tal_sun=0.67*(t2-t1);
teta=1.3*t1-0.29*t2;

Gp_sun=tf(K,[tal_sun 1],'io',teta);

figure (1)
step(Gp,Gp_sun);
legend('Processo','Modelo Sundaresan');  

    case {4}
        
        % Modelo Nishikawa processo   
        
A0=sum(y(end)-y)*dt;
t0=A0/y(end);
[~,I0]=min(abs(t0-t));
A1=sum(y(1:I0))*dt;

tal_n=A1/(0.368*y(end));
teta=t(I0)-tal_n;

Gp_n=tf(K,[tal_n 1],'io',teta);

figure (1)
step(Gp,Gp_n);
legend('Processo','Modelo Nishikawa');

    otherwise
    
disp('Escolha um método válido!');
    
end

%% Ch4.P2 
% Processo:

Gp=tf(10,conv([0.2 1 0],[0.5 1]));

w=logspace(-3,2);
% bode(Gp,w);
% grid;

% Sistema e assíntota:

g1=tf(100,[1 0 0 0]);    % para plotar assíntota
g2=tf(10,[1 0]);

figure (1);
bode(Gp,'r',g1,'b--',g2,'g--',w);
grid;

% ver bodeplot e opções

%% Ch4.P3
% i)

% Curva típica de processo com pólo
% real em -1/80 e ganho estático 4.2:

G1=tf(4.2170,[1/90 1])

figure (1)
bode(G1,{10,1000});
grid;
title('resposta em frequência G1(s)');

% ii)

% Curva típica de processo com 2 pólos
% reais em -1/0.06, um zero em -1/0.4
% e ganho estático 10:

%G2=tf(10,conv([.01 1],[.01 1]));

G2=tf(10*[2.5 1],conv([1/0.06 1],[1/0.06 1]))

figure (2)
bode(G2,{.001,10});
grid;
title('resposta em frequência G2(s)');

% iii)

% Curva típica de processo com 2 pólos
% reais em -1/6 e em -1/1400, dois zeros
% iguais em -1/60 e ganho estático 10:

%G3=zpk([-1/60 -1/60],[-1/6 -1/1400],10);

G3=tf(10*conv([1/60 1],[1/60 1]),conv([1/6 1],[1/1400 1]))

figure (3)
bode(G3,{.1,10^4});
grid;
title('resposta em frequência G3(s)');