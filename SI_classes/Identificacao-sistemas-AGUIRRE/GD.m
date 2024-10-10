% Gradient-Descent
% function x = GD(x0,y0,GD_gain,thresh,max_iter)
% ii = 1;
% delf(ii) = 1;
% x(ii) = x0;
% y(ii) = y0;
% 
% while(ii<max_iter) && (delf(ii)>thresh)
%     temp=[delfx(x(ii),y(ii));delfy(x(ii),y(ii))];
% 
% 
% 
% end

thresh=1e-5;
max_iter=10000;

%% Gradient-Descent

ii=1;
delf(ii)=1;
x(ii)=x0;
y(ii)=y0;
GD_gain=0.02;

while (ii<max_iter) && (delf(ii)>thresh)
    temp=[delfx(x(ii),y(ii));delfy(x(ii),y(ii))];
    ii=ii+1;
    x(ii)=x(ii-1)-GD_gain*temp(1)/norm(temp);
    y(ii)=y(ii-1)-GD_gain*temp(2)/norm(temp);
    delf(ii)=abs(f(x(ii),y(ii))-f(x(ii-1),y(ii-1)));
end

[XX,YY]=meshgrid(-5:0.1:5,-5:0.1:5);
ZZ=f(XX,YY);
figure(1);
contour(XX,YY,ZZ);
hold on;
plot(xstar,ystar,'r*');
h=plot(x(1),y(1),'ko','MarkerFaceColor','k');
xlabel('x');
ylabel('y');
axis([-5 5 -5 5]);

for ii=2:10:length(x)
    set(h,'XData',x(ii));
    set(h,'YData',y(ii));
    drawnow;
    pause(0.1);
end
plot(x,y,'k-o','MarkerFaceColor','k');
% pause(1);

% figure(2);
% plot(f(x,y))
% xlabel('ii');
% ylabel('f(ii)');