%cap5problemas
%Ch5.P1
nit=input(' Quantas iterações? ');
%nit=nit+1;

u=[1;-1;-1;1;-1;1];
y=[2.15;-1.94;-2.05;1.98;-2.10;2.10];
teta=0;

t=1:nit;
Y=[];fi=[];
for k=1:nit;
    Y=[Y;y(k)];
    fi=[fi;u(k)];
end

teta=inv(fi'*fi)*fi'*Y;

for t=1:nit;
    ye(t)=teta*u(t);
end

plot(Y);
hold on
plot(ye,'r');
xlabel('amostras');
ylabel('y , ye');
legend('y','ye');

%% Ch5.P2
%nit=input(' Quantas iterações? ');
%nit=nit+1;

u=[1.197;-1.830;-0.420;-0.5721;-0.287;0.435;-1.404;0.193; ...
    -1.771;0.701;-0.389;-1.040;-1.256;0.966];
y=[0;0.239;-0.486;0.159;0.194;0.0039;0.0067;-0.315;0.196; ...
   -0.452;0.366;-0.261;-0.077;-0.212];
% teta=[0;0];
nit=length(u);

%t=1:nit;
Y=0;fi=[0 0];
for k=2:nit;
    Y=[Y;y(k)];
    fi=[fi;-y(k-1) u(k-1)];
end

teta=inv(fi'*fi)*fi'*Y;
a1=teta(1);b0=teta(2);
ye(1)=0;

for t=2:nit;
    ye(t)=-a1*y(t-1)+b0*u(t-1);
end

plot(Y);
hold on
plot(ye,'r');
xlabel('amostras');
ylabel('y , ye');
legend('y','ye');

%% Coelho Ch5.P3

t=0:10;

u=[0;1;-1;1;1;1;-1;-1;0;0;0];
y=[0;1.1;-0.2;0.1;0.9;1;0.1;-1.1;-0.8;-0.1;0];

Y=0;fi=[0 0];

for k=2:11;
    
    Y=[Y;y(k)];
    fi=[fi;u(k) u(k-1)];
    
end

teta=inv(fi'*fi)*fi'*Y;
b0=teta(1);b1=teta(2);

ye=zeros(11,1);

for k=2:11;
    ye(k)=b0*u(k)+b1*u(k-1);
end

plot(t,y,t,ye);
xlabel('tempo');
ylabel('y , ye');
legend('y','ye');


%% Coelho Ch5.P5

t=0:19;

u1=ones(20,1);                      % entradas
u2=t';
u3=sin(pi*t/5)';

y1=zeros(20,1); y2=y1; y3=y1;       % saídas

for n=3:20;

y1(n)=0.6*y1(n-1)-0.05*y1(n-2)+0.5*u1(n-1);
y2(n)=0.6*y2(n-1)-0.05*y2(n-2)+0.5*u2(n-1);
y3(n)=0.6*y3(n-1)-0.05*y3(n-2)+0.5*u3(n-1);

end

fi1=[0 0];
fi2=[0 0];
fi3=[0 0];

for k=2:20;
    
    fi1=[fi1;-y1(k-1) u1(k-1)];
    fi2=[fi2;-y2(k-1) u2(k-1)];
    fi3=[fi3;-y3(k-1) u3(k-1)];
    
end

teta1=inv(fi1'*fi1)*fi1'*y1;
teta2=inv(fi2'*fi2)*fi2'*y2;
teta3=inv(fi3'*fi3)*fi3'*y3;

ye1=fi1*teta1;
ye2=fi2*teta2;
ye3=fi3*teta3;



subplot(3,1,1)
plot(t,y1,t,ye1,'r',t,u1,'g');
title('saídas real e estimada com entradas');

subplot(3,1,2)
plot(t,y2,t,ye2,'r',t,u2,'g');
ylabel('y , ye , u');

subplot(3,1,3)
plot(t,y3,t,ye3,'r',t,u3,'g');
xlabel('tempo');
