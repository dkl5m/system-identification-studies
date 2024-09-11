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