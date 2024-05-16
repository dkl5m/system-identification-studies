%cap5problemas
%P1
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

%%
%P2
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