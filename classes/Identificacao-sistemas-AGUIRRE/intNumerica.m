t0=0;
tf=150;
h=0.01;
t=t0:h:tf;

x0=[0.1;0.1;0.1]; % initial conditions
% initialization
x=[x0 zeros(length(x0),length(t)-1)];
u=zeros(length(t),1); % no external force (no input)

for k=2:length(t)
    x(:,k)=rkCord(x(:,k-1),u(k),u(k),h,t(k));
end

function x=rkCord(x0,ux,uy,h,t)
% 1st evaluation
xd=dvCord(x0,ux,uy,t)
savex0=x0;
phi=xd;
x0=savex0+0.5*h*xd;

% 2nd evaluation
xd=dvCord(x0,ux,uy,t+0.5*h)
phi=phi+2*xd;
x0=savex0+0.5*h*xd;

% 3rd evaluation
xd=dvCord(x0,ux,uy,t+0.5*h)
phi=phi+2*xd;
x0=savex0+1*h*xd;

% 4th evaluation
xd=dvCord(x0,ux,uy,t+h)
x=savex0+(phi+xd)*h/6;
end

function xdot=dvCord(x,ux,uy,t)
a=0.258;
b=4.033;
F=8;
G=1;

xd(1)=-x(2)-x(3)-a*x(1)+a*F;
xd(2)=x(1)*x(2)-b*x(1)*x(3)-x(2)+G;
xd(3)=b*x(1)*x(2)+x(1)*x(3)-x(3);
xdot=xd';
end