%% Exemplo 6.1 - tecnica do rele
% Modelagem matematica: partes real e imaginaria
% Rele com histerese
% Planta de segunda ordem
close all; clear; clc;

Tamostra=1;npts=100;d=0.5;eps=0.0870;
for t=1:7
    u(t)=-d;e(t)=0;y(t)=0;tempo(t)=t*Tamostra;
end
for t=5:npts                            % experimentacao com rele
    y(t)=1.436*y(t-1)-0.5134*y(t-2)+...
        0.04286*u(t-2)+0.03431*u(t-3);
    e(t)=-y(t);
    if((abs(e(t))>eps)&&(e(t)>0)); u(t)=+d; end
    if((abs(e(t))>eps)&&(e(t)<0)); u(t)=-d; end
    if((abs(e(t))<eps)&&(u(t-1)==+d)); u(t)=+d; end
    if((abs(e(t))<eps)&&(u(t-1)==-d)); u(t)=-d; end
    if(e(t)==+eps); u(t+1)=+d; end
    if(e(t)==-eps); u(t+1)=-d; end
    tempo(t)=t*Tamostra;
end
ch=0;i=1;
for k=4:npts                            % periodo
    s1=u(k);s2=u(k-1);
    if s1~=s2
        ch=ch+1;
        i=i+1;
    end
end
per=((npts+4)/ch)*2*Tamostra;
omega=(2*pi)/(per);
arm=eps;                                % valor de pico
for t=1:npts
    if y(t)>=arm; arm=y(t);end
end
a=arm;
realG=-(pi*sqrt(a^2-eps^2))/(4*d);      % partes real e imaginaria
imag=-(pi*eps)/(4*d);
saida=[u;y];plot(tempo,saida);


%% Exemplo 6.2 - rele nao-simetrico
% Metodo do rele para identificacao de um modelo
%   de primeira ordem com atraso de transporte, isto eh,
%   Gp(s)=K*exp(-teta1*s)/(tau1*s+1)
% Os vetores ur e yr sao obtidos atraves do simulink
close all; clear; clc;

d0=2;d1=0.5;d2=0.5;eps0=2;eps=0.3;nptos=80;Tamostra=0.1;
nptos1=nptos/Tamostra;kont=0;
for t=2:nptos1
    if ur(t)~=ur(t-1)
        kont=kont+1;ch(kont)=t;
    end
end
Tu1=(ch(6)-ch(5))*Tamostra; Tu2=(ch(5)-ch(4))*Tamostra;
aux1=ch(3);aux2=ch(5);i=0;
for t=aux1:aux2
    i=i+1;
    yi(i)=yr(t);ui(i)=ur(t);
    ti(i)=i*Tamostra;
end
a1=0.5*([0 yi]+[yi 0]).*([ti 0] - [0 ti]);
a1=sum(a1(1,2:length(yi)));
a2=0.5*([0 ui]+[ui 0]).*([ti 0] - [0 ti]);
a2=sum(a2(1,2:length(ui)));
k = a1/a2
arm=d0;
for t=aux1:aux2
    if yr(t)>=arm
        arm=yr(t); end
end
Au=arm;
arm=d0;
for t=aux1:aux2
    if yr(t)<=arm
        arm=yr(t); end
end
Ad=arm;
teta=log(((d1-d0)*K-eps+eps0)/((d1-d0)*K+Ad));
x1=(d1+d2)*K*exp(teta)-(d1-d0)*K+eps-eps0;
x2=(d0+d2)*K-eps-eps0;
tau1=Tu1/log(x1/x2);
teta1=tau1*teta

