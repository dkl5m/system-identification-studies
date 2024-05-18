% 1) Considerar as seguintes condicoes de operacao e os sistemas de
%    controle nao-lineares:
% i) rele sem histerese
%    amplitude do rele d = 1
%    planta terceira ordem Gp(s)=Y(s)/U(s)=10/(s(s+1)(s+2));
%    determinar amplitude e frequencia ciclo-limite da saida

clc;close;clear;

num=10;
den=[1 3 2 0];
g=tf(num,den);  % funcao de transferencia
d=1;            % amplitude do rele
Ts=1;           % tempo de amostragem
h=0;            % histerese
sysd=c2d(g,Ts); % discretiza a funcao
[numd,dend]=tfdata(sysd,'v');

npts=100;
for t=1:8
    u(t)=-d;e(t)=0;y(t)=0;tempo(t)=t*Ts;
end

for t=6:npts    %Experimento relay
    y(t)=-dend(2)*y(t-1)-dend(3)*y(t-2)-dend(4)*y(t-3)+...
    numd(2)*u(t-1)+numd(3)*u(t-2)+numd(4)*u(t-3); % tf discretizada
    e(t)=-y(t);
    if (e(t)>0)
        u(t)=d;
    end
    if (e(t)<0)
        u(t)=-d;
    end
end

ch=0; i=1;
for k=4:npts
    s1=u(k);s2=u(k-1);
    if s1~=s2
        ch=ch+1;
        i=i+1;
    end
end

per=((npts+4)/ch)*2*Ts;
w=(2*pi)/per;           % acha frequencia
arm=h;
arm2=h;
for t=1:npts            % acha valor maximo
    if y(t)>=arm
        arm=y(t);
    end
end
for t=1:npts            % acha valor minimo
    if y(t)<=arm2
        arm2=y(t);
    end
end

ampd=(abs(arm-arm2))/2;

% PLOT
saida=[u;y];
plot(y,'k');
hold on;
plot(u,'r');

%%
% ii) rele com histerese
%     amplitude do rele d = 5
%     histerese epsilon = 1
%     planta primeira ordem Gp(s)=Y(s)/U(s)=3e(-0.1s)/(2s+1);
%     determinar amplitude e frequencia ciclo-limite da saida

clc;close;clear;

num=3;
den=[2 1];
g=tf(num,den,'io',0.1);  % funcao de transferencia
d=5;            % amplitude do rele
Ts=1;           % tempo de amostragem
h=1;            % histerese
sysd=c2d(g,Ts); % discretiza a funcao
[numd,dend]=tfdata(sysd,'v');

npts=10;
for t=1:8
    u(t)=-d;e(t)=0;y(t)=0;tempo(t)=t*Ts;
end

for t=4:npts    %Experimento relay
    y(t)=-dend(1)*y(t-1)+numd(1)*u(t-1)+numd(2)*u(t-2); % tf discretizada
    e(t)=-y(t);
    
    if(abs(e(t))>h) && (e(t)>0)
        u(t)=+d;
    end
    if(abs(e(t))>h) && (e(t)<0)
        u(t)=-d;
    end
    
    if(abs(e(t))<h) && (u(t-1)==+d)
        u(t)=+d;
    end
    if(abs(e(t))<h) && (u(t-1)==-d)
        u(t)=-d;
    end

    if (e(t)==+h)
        u(t+1)=+d;
    end
    if (e(t)==-h)
        u(t+1)=-d;
    end
    tempo(t)=t*Ts;
end

ch=0; i=1;
for k=4:npts
    s1=u(k);s2=u(k-1);
    if s1~=s2
        ch=ch+1;
        i=i+1;
    end
end

per=((npts+4)/ch)*2*Ts;
w=(2*pi)/per;           % acha frequencia

npts1=npts/Ts;kont=0;
for t=2:npts1
    if(u(t)~=u(t-1))
        kont=kont+1;
        ch(kont)=t;
    end
end

Tu1=(ch(6)-ch(5))*Ts;
Tu2=(ch(5)-ch(4))*Ts;
aux1=ch(3);
aux2=ch(5);
i=0;
for t=aux1:aux2
    i=i+1;
    yi(i)=y(t);
    ui(i)=u(t);
    ti(i)=i*Ts;
end

a1=d*([0 yi]+[yi 0]).*([ti 0]-[0 ti]);
a1=sum(a1(1,2:length(yi)));
a2=d*([0 ui]+[ui 0]).*([ti 0]-[0 ti]);
a2=sum(a2(1,2:length(yi)));
K=a1/a2;    % ganho

arm=d;
for t=aux1:aux2
    if y(t)>=arm
        arm=y(t);
    end
end
Au=arm;     % pico positivo

arm=d;
for t=aux1:aux2
    if y(t)<=arm
        arm=y(t);
    end
end
Ad=arm;     % pico negativo e atraso
ampd=(abs(Au-Ad))/2;
% d2=0;
% d1=d2;
% h0=d1;
% teta=log(((d1-d)*K-h+h0)/((d1-d)*K+Ad));
% x1=(d1+d2)*K*exp(teta)-(d1-d)*K+h-h0;
% x2=(d+d2)*K-h-h0;
% tau1=Tu1/log(x1/x2);
% teta1=tau1*teta;

% PLOT
saida=[u;y];
plot(y,'k');
hold on;
plot(u,'r');