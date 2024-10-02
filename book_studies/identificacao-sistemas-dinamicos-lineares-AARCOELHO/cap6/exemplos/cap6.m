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