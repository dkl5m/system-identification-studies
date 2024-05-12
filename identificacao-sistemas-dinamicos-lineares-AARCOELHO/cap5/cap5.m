%% Exemplo 5.1
% Estimador dos mínimos quadrados não-recursivo
% Processo de segunda ordem

load exchanger.dat
%t=exchanger(100:500,1);
u=exchanger(100:500,2);
y=exchanger(100:500,3);

N=length(u);
Y=[];fi=[];
for j=1:N
  if j<=2
     y1=0;y2=0;u1=0;u2=0;
  else
      y1=y(j-1);y2=y(j-2);u1=u(j-1);u2=u(j-2);
  end   
  Y=[Y; y(j)];fi=[fi;-y1 -y2 u1 u2]; 
end
teta=inv(fi'*fi)*fi'*Y; 
for k=1:2
    yest(k)=0;
end
a1=teta(1);a2=teta(2);b1=teta(3);b2=teta(4);
for k=3:N
    yest(k)=-a1*yest(k-1)-a2*yest(k-2)+b1*u(k-1)+b2*u(k-2);
end

plot(y,'g');
hold on
plot(yest,'r');

ye=fi*teta;
hold on;
plot(ye,'b');


%% Estimador dos mínimos quadrados não-recursivo
% Exemplo 5.2

%Dados de entrada e saída:

t=0:14;
u=zeros(15,1);
u(1)=1;u(2:6)=0.8:-0.2:0;u(7:11)=0.2:0.2:1;u(12:15)=u(2:5);
y=zeros(15,1);
y(1)=0.9;y(2)=2.5;y(3)=2.4;y(4)=1.3;y(5)=1.2;y(6)=0.8;y(7)=0;
y(8)=0.9;y(9)=1.4;y(10)=1.9;y(11)=2.3;y(12)=2.4;y(13)=2.3;
y(14)=1.3;y(15)=1.2;

N=input('Escolha N:');

Y=[y(2)];fi=[u(2) u(1)];

for k=3:N+1;
    
    fi=[fi;u(k) u(k-1)];
    Y=[Y;y(k)];
end

teta=inv(fi'*fi)*fi'*Y

b0=teta(1)
b1=teta(2)



%% Exemplo 5.3
% Estimador dos minimos quadrados recursivo
% Planta de segunda ordem
clear; clc;

nit = input(' Quantas iteracoes? ');
% u(i) = 0.1;
for i = 1:nit                            % Entrada e ruido
    if rand > 0.5
        u(i) = 1;
    else
        u(i) = -1;
    end
end
e = u*0.01;
p = 1000*eye(4,4); teta = [0;0;0;0];    % Condicoes iniciais
for t = 1:4
    y(i) = 0; erro(t) = 0;
    a1(t) = teta(1); a2(t) = teta(2);
    b0(t) = teta(3); b1(t) = teta(4);
end
for t = 4:nit
    y(t) = 1.5144 * y(t-1) - 0.5506 * y(t-2) + ...
        0.599 * u(t-1) + 0.163 * u(t-2) + e(t);
    fi = [-y(t-1); -y(t-2); u(t-1); u(t-2)];
    erro(t) = y(t) - teta'*fi;          % Erro de estimacao
    k = p*fi/ (1+fi'*p*fi);             % Ganho do estimador
    teta = teta + k*erro(t);            % Vetor de parametros
    p = (p - k*fi'*p);                  % Matriz de covariancia
    a1(t) = teta(1); a2(t) = teta(2);
    b0(t) = teta(3); b1(t) = teta(4);
end

t = 1:nit;                              % Parametros estimados
subplot(221), plot(t,a1(t)), title('a1'), xlabel('amostragem');
subplot(222), plot(t,a2(t)), title('a2'), xlabel('amostragem');
subplot(223), plot(t,b0(t)), title('b0'), xlabel('amostragem');
subplot(224), plot(t,b1(t)), title('b1'), xlabel('amostragem');

%% Exemplo 5.4
% Sequencia binaria pseudo-aleatoria
clc; clear;

delta = input('Intervalo de integracao delta t = ');
tf = input('Tempo final tf = ');
t = 0:delta:tf; sna=rand(size(t));l=0;

while l==0
    alfa=input('Valor de alfa = ');
    if alfa<=1
        if alfa>=0
            l=1;
        end
    end
    if l==0
        disp('Alfa deve estar entre 0 e 1');
    end
end

for i=1:length(t);
    if sna(i)<=alfa, sbpa(i)=-1;
    else sbpa(i)=1;
    end
end
plot(t,sbpa);

%% Exemplo 5.5
% Estimador da variavel instrumental
% Planta de segunda ordem
clear; clc;

nit = input(' Quantas iteracoes? ');
% u(i) = 0;
for i = 1:nit                            % Entrada e ruido
    if rand > 0.5
        u(i) = 1;
    else
        u(i) = -1;
    end
end
e = u*0.1;
lambda = 1; p = 1000*eye(4,4);          % Condicoes iniciais
teta = [0;0;0;0]; tetaaux = [0;0;0;0]; zeta = [0;0;0;0];
for t = 1:6
    y(i) = 0; x(t) = 0; erro(t) = 0;
    a1(t) = teta(1); a2(t) = teta(2);
    b0(t) = teta(3); b1(t) = teta(4);
end
for t = 6:nit
    y(t) = 1.5144 * y(t-1) - 0.5506 * y(t-2) + ...
        0.599 * u(t-1) + 0.163 * u(t-2) + e(t);
    fi = [-y(t-1); -y(t-2); u(t-1); u(t-2)];
    erro(t) = y(t) - teta'*fi;          % Erro de estimacao
    k = p*fi/ (1+fi'*p*fi);             % Ganho do estimador
    tetaaux = teta; teta = teta + k*erro(t);   % Vetor de parametros
    p = (p - k*fi'*p)/lambda;                  % Matriz de covariancia
    a1(t) = teta(1); a2(t) = teta(2);
    b0(t) = teta(3); b1(t) = teta(4);
end

t = 1:nit;                              % Parametros estimados
subplot(221), plot(t,a1(t)), title('a1'), xlabel('amostragem');
subplot(222), plot(t,a2(t)), title('a2'), xlabel('amostragem');
subplot(223), plot(t,b0(t)), title('b0'), xlabel('amostragem');
subplot(224), plot(t,b1(t)), title('b1'), xlabel('amostragem');


%% Exemplo 5.6
% Estimador da matriz estendida
clear; clc;

nit = input(' Quantas iteracoes? ');
% u(i) = 0;
for i = 1:nit                            % Entrada e ruido
    if rand > 0.5
        u(i) = 1;
    else
        u(i) = -1;
    end
end
e = u*0.1;
lambda = 1; p = 1000*eye(6,6);          % Condicoes iniciais
teta = [0;0;0;0;0;0];
for t = 1:6
    y(i) = 0; w(i) = 0; erro(t) = 0;
    a1(t) = teta(1); a2(t) = teta(2);
    b0(t) = teta(3); b1(t) = teta(4);
    c1(t) = teta(5); c2(t) = teta(6);
end
for t = 6:nit
    y(t) = 1.5 * y(t-1) - 0.7 * y(t-2) + u(t-1) + ...
         0.5 * u(t-2) + e(t) - e(t-1) + 0.2*e(t-2);
    fi = [-y(t-1); -y(t-2); u(t-1); u(t-2); w(t-1); w(t-2)];
    erro(t) = y(t) - teta'*fi;          % Erro de estimacao
    k = p*fi/ (lambda+fi'*p*fi);               % Ganho do estimador
    teta = teta + k*erro(t);                   % Vetor de parametros
    p = (p - k*fi'*p)/lambda;                  % Matriz de covariancia
    w(t)=y(t)-teta'*fi;
    a1(t) = teta(1); a2(t) = teta(2);
    b0(t) = teta(3); b1(t) = teta(4);
    c1(t) = teta(5); c2(t) = teta(6);
end

t = 1:nit;                              % Parametros estimados
subplot(221), plot(t,a1(t)), title('a1'), xlabel('amostragem');
subplot(222), plot(t,a2(t)), title('a2'), xlabel('amostragem');
subplot(223), plot(t,b0(t)), title('b0'), xlabel('amostragem');
subplot(224), plot(t,b1(t)), title('b1'), xlabel('amostragem');


%%
% Coelho Ch 5
% MQR com random walk
% Exemplo 5.7

N=801;

u=zeros(N,1);
for k=1:N;
    
    if rand>0.5;
        u(k)=1;
    else
        u(k)=-1;
    end
end

e=0.01*u;

% e=zeros(N,1);
% for k=1:N;
%     
%     if rand>0.5;
%         e(k)=0.01;
%     else
%         e(k)=-0.01;
%     end
% end


y=zeros(N,1);
p=100*eye(3); teta=[0;0;0];
a1=zeros(N,1); b0=zeros(N,1); b1=zeros(N,1);
erro=zeros(N,1);

Q=0.1*eye(3);
% Q=10*eye(3);

for n=3:N;
    
    if n>=201;
        au=0.35;
    else
        au=0.7;
    end
        
    y(n)=-au*y(n-1)+u(n-1)+0.5*u(n-2)+e(n);
    
    fi=[-y(n-1);u(n-1);u(n-2)];
    erro(n)=y(n)-fi'*teta;
   
    k=p*fi/(1+fi'*p*fi);
    teta=teta+k*erro(n);
    p=(p-k*fi'*p); 
     
    if n==201;              % random walk
    p=p+Q;
    end    
    
    a1(n)=teta(1); b0(n)=teta(2); b1(n)=teta(3);
end

t=0:N-1;
aum=0.7*ones(N,1);aum(201:N,1)=0.35*ones(601,1);
bz=ones(N,1); bum=0.5*ones(N,1);

subplot(311);
plot(t,a1,t,aum,'--');
title('a1');
xlabel('tempo');

subplot(312);
plot(t,b0,t,bz,'--');
title('b0');
xlabel('tempo');

subplot(313);
plot(t,b1,t,bum,'--');
title('b1');
xlabel('tempo');


%%
% Exemplo Coelho 5.8

N=801;

u=zeros(N,1);

for n=1:N
  
  if rand>0.5;
    u(n)=1;
  else
    u(n)=-1;
  end
 end
e=0.01*u;  teta=[0;0;0];
a1=zeros(N,1);a2=zeros(N,1);b0=zeros(N,1);
y=zeros(N,1);

fi=[0;0;0];
p=100*eye(3);
%lambda=0.99;
lambda=0.97;

for k=3:N;
  
  if k<201;
    b=1;
  else
    b=2;
  
  end  
  y(k)=-y(k-1)-0.25*y(k-2)+b*u(k-1)+e(k);

  fi=[-y(k-1);-y(k-2);u(k-1)];
  erro(k)=y(k)-fi'*teta;
  K=p*fi/(lambda+fi'*p*fi);
  teta=teta+K*erro(k);
  p=(p-K*fi'*p')/lambda;
  
  a1(k)=teta(1); a2(k)=teta(2); b0(k)=teta(3);

end
t=1:N; t=t';
au=ones(N,1); ad=0.25*ones(N,1);
b=ones(N,1);b(201:N)=2;

figure 1;
plot(t,a1);
hold on
plot(t,au,'r--');
title('a1'); xlabel('Amostras');

figure 2;
plot(t,a2);
hold on
plot(t,ad,'r--');
title('a2'); xlabel('Amostras');

figure 3;
plot(t,b0);
hold on
plot(t,b,'r--');
title('b0'); xlabel('Amostras');                                                                                                                                 