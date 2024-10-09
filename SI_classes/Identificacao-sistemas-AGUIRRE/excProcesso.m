% configuracoes simulacao
t0=0;
tm=6000;
fd=60*tm;
h=10;
t=t0:h:tf;

% entradas
Q1=2.71*ones(1,length(t));
Q3=[];
levels=0:0.1:6;
width=round(length(t)/length(levels));

for j=1:length(levels)-1
    Q3=[Q3 levels(j)*ones(1,width)];
end
Q3=[Q3 levels(j+1)*ones(1,length(t).length(Q3))];

u1=Q1;
u3=Q3;


% integracao numerica
x=zeros(length(x0),length(t));
x(:,1)=x0;
