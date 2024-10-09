% Ch5.P6
% Selecionar os valores de (na,nb) para que o programa estime os
% parâmetros correspondentes do modelo. Considere a convenção:
% 1-(1,0), 2-(1,1), 3-(2,0) e 4-(2,1)

help p_coelho_6

N=100;
t=0:N-1;

for i=1:N;
    
    if rand>0.5
        u(i)=1;
    else
        u(i)=-1;
    end
end

e=u*0.01;

y=zeros(N,1); erro=y;

nn=input('Escolha um modelo:');

switch nn
    
    case {1}
        
p=1000*eye(2);teta=zeros(2,1);

a1=zeros(N,1);b0=a1;

for n=3:N;
    
    y(n)=1.5*y(n-1)-0.7*y(n-2)+u(n-1)+0.5*u(n-2)+e(n);

    fi=[-y(n-1);u(n-1)];%vetor fi
    erro(n)=y(n)-fi'*teta;
    K=p*fi/(1+fi'*p*fi);
    teta=teta+K*erro(n);
    p=p-K*fi'*p';
    a1(n)=teta(1);b0(n)=teta(2);
    
end

'p'
disp(p);

subplot 211
plot(t,a1);
title('a1');
xlabel('tempo');

subplot 212
plot(t,b0);
title('b0');
xlabel('tempo');

figure (2)

plot(t,erro);
title('Erro de previsão');
xlabel('tempo');

    case{2}
        
p=1000*eye(3);teta=zeros(3,1);

a1=zeros(N,1);b0=a1;b1=a1;

for n=3:N;
    
    y(n)=1.5*y(n-1)-0.7*y(n-2)+u(n-1)+0.5*u(n-2)+e(n);

    fi=[-y(n-1);u(n-1);u(n-2)];%vetor fi
    erro(n)=y(n)-fi'*teta;
    K=p*fi/(1+fi'*p*fi);
    teta=teta+K*erro(n);
    p=p-K*fi'*p';
    a1(n)=teta(1);b0(n)=teta(2);b1(n)=teta(3);
    
end

'p'
disp(p);

subplot 221
plot(t,a1);
title('a1');
xlabel('tempo');

subplot 222
plot(t,b0);
title('b0');
xlabel('tempo');

subplot 223
plot(t,b1);
title('b1');
xlabel('tempo');

figure (2)

plot(t,erro);
title('Erro de previsão');
xlabel('tempo');

    case {3}
        
p=1000*eye(3);teta=zeros(3,1);

a1=zeros(N,1);a2=a1;b0=a1;

for n=3:N;
    
    y(n)=1.5*y(n-1)-0.7*y(n-2)+u(n-1)+0.5*u(n-2)+e(n);

    fi=[-y(n-1);-y(n-2);u(n-1)];%vetor fi
    erro(n)=y(n)-fi'*teta;
    K=p*fi/(1+fi'*p*fi);
    teta=teta+K*erro(n);
    p=p-K*fi'*p';
    a1(n)=teta(1);a2(n)=teta(2);b0(n)=teta(3);
    
end

'p'
disp(p);

subplot 221
plot(t,a1);
title('a1');
xlabel('tempo');

subplot 222
plot(t,a2);
title('a2');
xlabel('tempo');

subplot 223
plot(t,b0);
title('b0');
xlabel('tempo');

figure (2)

plot(t,erro);
title('Erro de previsão');
xlabel('tempo');

    case {4}
        
p=1000*eye(4);teta=zeros(4,1);

a1=zeros(N,1);a2=a1;b0=a1;b1=a1;

for n=3:N;
    
    y(n)=1.5*y(n-1)-0.7*y(n-2)+u(n-1)+0.5*u(n-2)+e(n);

    fi=[-y(n-1);-y(n-2);u(n-1);u(n-2)];%vetor fi
    erro(n)=y(n)-fi'*teta;
    K=p*fi/(1+fi'*p*fi);
    teta=teta+K*erro(n);
    p=p-K*fi'*p';
    a1(n)=teta(1);a2(n)=teta(2);b0(n)=teta(3);b1(n)=teta(4);
    
end

'p'
disp(p);

subplot 221
plot(t,a1);
title('a1');
xlabel('tempo');

subplot 222
plot(t,a2);
title('a2');
xlabel('tempo');

subplot 223
plot(t,b0);
title('b0');
xlabel('tempo');

subplot 224
plot(t,b1);
title('b1');
xlabel('tempo');

figure (2)

plot(t,erro);
title('Erro de previsão');
xlabel('tempo');

    otherwise
        
        clear;clc
        p_coelho_6;

end


%% Ch5.P7

N=input('Quantas iterações?');

for n=1:N;
    
    if rand>0.5;
    e(n)=0.05;
    else 
    e(n)=-0.05;   
    end
end

%u=zeros(N,1);         % i) condição 1
%u=ones(N,1);           % ii) condição 2

% for n=1:N;              % iii) condição 3
% 
%                         
%     if rand>0.5;
%     u(n)=1;
%     else 
%     u(n)=-1;   
%     end
% end

for n=1:N;              % v) condição 5

                        
    if rand>0.5;
    r(n)=1;
    else 
    r(n)=-1;   
    end
end

u=0;                  % para condições de 4 a 7

y=zeros(N,1);         % condições iniciais

p=10*eye(2); teta=[0;1];
a1(1)=0; b0(1)=1;

for k=2:N;
    
    y(k)=0.5*y(k-1)+u(k-1)+e(k);
%     u(k)=0.1*y(k);      % iv) condição 4 
      u(k)=0.1*y(k)+r(k); % v) condição 5
%     u(k)=0.1*y(k-1);        % vi) condição 6 
%       u(k)=0.1*sign(y(k));      % vii) condição 7
    
    fi=[-y(k-1);u(k-1)];
    erro(k)=y(k)-fi'*teta;
    K=p*fi/(1+fi'*p*fi);
    teta=teta+K*erro(k);
    p=p-K*fi'*p';
    
    a1(k)=teta(1); b0(k)=teta(2);
    
end

t=0:N-1;

subplot (211)
plot(t,a1);
title('a1');
xlabel('tempo');

subplot (212)
plot(t,b0);
title('b0');
xlabel('tempo');


%% Ch5.P8

%N=101;
N=150;

for k=1:N;
    
    if rand>0.5;
        u(k)=1;
    else
        u(k)=-1;
    end
end

e=0.01*u;

y=zeros(N,1);
p=10*eye(2); teta=[0;0];
a1=zeros(N,1); b0=zeros(N,1);
erro=zeros(N,1);

% i) fator de esquecimento:

lambda=1;
%lambda=0.9;

% ii) random walk:
Q=diag([0,0.05]);
%Q=diag([0,0.25]);
bzeros=zeros(N,1);bzeros(1)=2;

for n=2:N;
    
    if (n>=22 && n<=41)||(n>=62 && n<=81);
        bzeros(n)=3;
%     elseif n<=41;    
%         bzeros(n)=3;
%     elseif n<=61;
%         bzeros(n)=2;
%     elseif n<=81;
%         bzeros(n)=3;
    else
        bzeros(n)=2;
    end
        
    y(n)=0.8*y(n-1)+bzeros(n)*u(n-1)+e(n);
    
    fi=[-y(n-1);u(n-1)];
    erro(n)=y(n)-fi'*teta;
    %k=p*fi/(lambda+fi'*p*fi);
    k=p*fi/(1+fi'*p*fi);
    teta=teta+k*erro(n);
    %p=(p-k*fi'*p)/lambda;
    p=(p-k*fi'*p);
    
   if (n==22 || n==42 || n==62 || n==82);              % random walk
        p=p+Q;
%     elseif n==42;
%         p=p+Q;
%     elseif n==62;
%         p=p+Q;
%     elseif n==82;
%         p=p+Q;
   end
     
    a1(n)=teta(1); b0(n)=teta(2);
end

t=0:N-1;
aum=-0.8*ones(N,1);

subplot(211);
plot(t,a1,t,aum,'--');
title('a1');
xlabel('tempo');

subplot(212);
plot(t,b0,t,bzeros,'--');
title('b0');
xlabel('tempo');
   
    
%% Ch5.P9

N=1000;

e=zeros(N,1);

for k=1:N;
 
  if rand>0.5;
  e(k)=1;
  else
  e(k)=-1;
  end
    
end

teta=[0;0]; tetap=[0;0];
y=zeros(N,1);

a1=zeros(N,1); a2=zeros(N,1); a1p=a1; a2p=a2;
p=10*eye(2);%;p2=p1;
erro=zeros(N,1); errop=erro;
%gama=0.005;             % ii) variável estocástica gama=cte.
gama=0.01;             % ii) variável estocástica gama=cte.

%alfa=0.1;                % i) variável estocástica gama apr. sequencial
%alfa=0.01;                % i) variável estocástica gama apr. sequencial
%beta=1;
%r=0.01;                      % iii) ganho com vetor total de medidas

for n=3:N;
  
  y(n)=1.5*y(n-1)-0.56*y(n-2)+e(n);
  
  fi=[-y(n-1);-y(n-2)];
  
  errop(n)=y(n)-fi'*tetap;
  K=p*fi/(1+fi'*p*fi);
  tetap=tetap+K*errop(n);
  p=p-K*fi'*p';
  
  erro(n)=y(n)-fi'*teta;
  %gama=alfa/(beta+fi'*fi);  % i) variável estocástica gama apr. sequencial
  teta=teta+gama*fi*erro(n); % i) e ii)
%   r=r+fi'*fi;
%   teta=teta+(1/r)*fi*erro(n); % iii) ganho com vetor total de medidas
  
  a1p(n)=tetap(1); a2p(n)=tetap(2);
  a1(n)=teta(1); a2(n)=teta(2);
    
end

t=0:N-1;
au=-1.5*ones(N,1);ad=0.56*ones(N,1);

subplot (211);
plot(t,a1,t,a1p,'k',t,au,'r--');
title('a1');
xlabel('tempo');

subplot (212);
plot(t,a2,t,a2p,'k',t,ad,'r--');
title('a2');
xlabel('tempo');


%% Ch5.P10
% Variável instrumental e matriz estendida
% N = 100, 500, 2000

help p_coelho_10.m
N=input('Quantas iterações?');

u=zeros(N,1);

for k=1:N;
   
    if rand>0.5;
        u(k)=1;
    else
        u(k)=-1;
    end
    
end
e=0.1*u;

y=zeros(N,1);

tetai=[0;0;0;0];
a1i=tetai(1); a2i=tetai(2); b1i=tetai(3); b2i=tetai(4);

tetae=[0;0;0;0;0;0];
a1e=tetae(1); a2e=tetae(2); b1e=tetae(3); b2e=tetae(4);
c1e=tetae(5); c2e=tetae(6);

z=[0;0;0;0]; fi=zeros(4,1);
pi=1000*eye(4); lambda=0.99; x=zeros(N,1);

fie=zeros(6,1); erroi=zeros(N,1); erroe=erroi;
w=zeros(N,1);
pe=1000*eye(6);

for n=3:N;
   
    y(n)=1.5*y(n-1)-0.7*y(n-2)+u(n-1)+0.5*u(n-2)+e(n)-e(n-1)+0.2*e(n-2); 
    
    z=[-x(n-1);-x(n-2);u(n-1);u(n-2)];
    fi=[-y(n-1);-y(n-2);u(n-1);u(n-2)];
    
    fie=[-y(n-1);-y(n-2);u(n-1);u(n-2);w(n-1);w(n-2)];
    
    x(n)=z'*tetai;
    
    erroi(n)=y(n)-tetai'*fi;
    Ki=pi*z/(lambda+fi'*pi*z);
    tetai=tetai+Ki*erroi(n);
    pi=(pi-Ki*fi'*pi)/lambda;
    
    erroe(n)=y(n)-tetae'*fie;
    Ke=pe*fie/(lambda+fie'*pe*fie);
    tetae=tetae+Ke*erroe(n);
    
    pe=(pe-Ke*fie'*pe)/lambda;
    w(n)=y(n)-tetae'*fie;
    
    a1i(n)=tetai(1); a2i(n)=tetai(2); b1i(n)=tetai(3); b2i(n)=tetai(4);
    
    a1e(n)=tetae(1); a2e(n)=tetae(2); b1e(n)=tetae(3); b2e(n)=tetae(4);
    c1e(n)=tetae(5); c2e(n)=tetae(6);
    
            
end

t=0:N-1;

% figure (1);
% title('Estimação por Variável Instrumental');
% 
% subplot (221);
% plot(t,a1i);
% title('a1');
% xlabel('tempo');
% 
% subplot (222);
% plot(t,a2i);
% title('a2');
% xlabel('tempo');
% 
% subplot (223);
% plot(t,b0i);
% title('b0');
% xlabel('tempo');
% 
% subplot (224);
% plot(t,b1i);
% title('b1');
% xlabel('tempo');
% 
% figure (2);
% title('Estimação por Matriz Estendida');
% 
% subplot (231);
% plot(t,a1e);
% title('a1');
% xlabel('tempo');
% 
% subplot (232);
% plot(t,a2e);
% title('a2');
% xlabel('tempo');
% 
% subplot (233);
% plot(t,b0e);
% title('b0');
% xlabel('tempo');
% 
% subplot (234);
% plot(t,b2e);
% title('b1');
% xlabel('tempo');
% 
% subplot (235);
% plot(t,c1e);
% title('c1');
% xlabel('tempo');
% 
% subplot (236);
% plot(t,c2e);
% title('c2');
% xlabel('tempo');

% figure;
% title('Estimação por Variável Instrumental e Matriz Estendida');

subplot (221);
plot(t,a1i,t,a1e,'r');
title('a1');
xlabel('tempo');
legend('VI','ME');

subplot (222);
plot(t,a2i,t,a2e,'r');
title('a2');
xlabel('tempo');
legend('VI','ME');

subplot (223);
plot(t,b1i,t,b1e,'r');
title('b1');
xlabel('tempo');
legend('VI','ME');

subplot (224);
plot(t,b2i,t,b2e,'r');
title('b2');
xlabel('tempo');
legend('VI','ME');