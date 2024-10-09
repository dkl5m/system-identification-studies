% Código Coelho 5.6
% Estimador da matriz estendida
nit=input(' Quantas iterações? ');

for i=1:nit;
  
  if rand>0.5;
    u(i)=1;
  else
    u(i)=-1;
    
  end 
end
e=u*0.1;

lambda=1;p=1000*eye(6);teta=[0;0;0;0;0;0];
for t=1:6;
  y(t)=0;w(t)=0;erro(t)=0;
  a1(t)=teta(1);a2(t)=teta(2);b0(t)=teta(3);b1(t)=teta(4);
  c1(t)=teta(5);c2(t)=teta(6);
end
for t=6:nit;
  y(t)=1.5*y(t-1)-0.7*y(t-2)+u(t-1)+0.5*u(t-2)+e(t)-e(t-1)+0.2*e(t-2);
  fi=[-y(t-1);-y(t-2);u(t-1);u(t-2);w(t-1);w(t-2)];
  erro(t)=y(t)-teta'*fi;
  k=p*fi/(lambda+fi'*p*fi);
  %w(t)=y(t)-teta'*fi;
  teta=teta+k*erro(t);
  p=(p-k*fi'*p)/lambda;
  w(t)=y(t)-teta'*fi;
  a1(t)=teta(1);a2(t)=teta(2);b0(t)=teta(3);b1(t)=teta(4);
  c1(t)=teta(5);c2(t)=teta(6);
  
end
t=1:nit;
subplot(221),plot(t,a1(t)),title('a1'),xlabel('amostragem');
subplot(222),plot(t,a2(t)),title('a2'),xlabel('amostragem');
subplot(223),plot(t,b0(t)),title('b0'),xlabel('amostragem');
subplot(224),plot(t,b1(t)),title('b1'),xlabel('amostragem');

figure (2)

subplot(211),plot(t,c1(t)),title('c1'),xlabel('amostragem');
subplot(212),plot(t,c2(t)),title('c2'),xlabel('amostragem');

%%
%Cálculo de teta
% close all
% clear all
% load 2ORDEM
% 
% y=(Y_2ORDEM)';
% u=U_2ORDEM;

load exchanger.dat
t=exchanger(1:400,1);
y=exchanger(1:400,2);
u=exchanger(1:400,3);
Y=[];
%N=input('N:');
N=length(t);
na=input('na:');
nb=input('nb:');
d=input('d:');
fi=[];
for j=1:N
  y1=[];
  for i=1:na
   if j<=i
     y0=0;
  else
      y0=y(j-i);
  end   
  y1=[y1 -y0]; 
  end
  u1=[];
  for i=0:nb
  if j<=(i+d)
     u0=0;
  else
      u0=u(j-i-d);
  end
  u1=[u1 u0]; 
  end 
  fi=[fi ;y1 u1];
end

for i=1:N
    Y(i,1)=y(i);
end

tetaest=inv(fi'*fi)*fi'*Y;
yest=fi*tetaest;
e=(y-yest);
J=e'*e;
R2=1-((y-yest)'*(y-yest))/((y-mean(y))'*(y-mean(y)));
fprintf('J:%f and R2:%f', J, R2);
