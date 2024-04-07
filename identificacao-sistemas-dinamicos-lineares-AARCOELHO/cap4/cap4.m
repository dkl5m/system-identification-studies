%% Exemplo 4.3
% Estimacao de modelo 2a ordem por metodo Mollenkamp
clear; clc;

t1 = input(' valor de t1(15%): ');
t2 = input(' valor de t2(45%): ');
t3 = input(' valor de t3(75%): ');
x = (t2 - t1)/(t3 - t1);
zeta = (0.0805 - (5.547*(0.475 - x)^2))/(x - 0.356);
if zeta < 1
    f2 = (0.708)*(2.811^zeta);
else
    f2 = (2.6*zeta) - 0.60;
end

wn = f2/(t3 - t1);
f3 = (0.922)*(1.66^zeta);
teta = t2 - (f3/wn);
tal1 = (zeta + sqrt(zeta^2-1))/wn;
tal2 = (zeta - sqrt(zeta^2-1))/wn;
if zeta < 1
    disp('fator de amortecimento')
    zeta
    disp('frequencia natural')
    wn
    disp('atraso de transporte')
    teta
else
    disp('constante de tempo 1')
    tal1
    disp('constante de tempo 2')
    tal2
    disp('atraso de transporte')
    teta
end

%% Exemplo 4.6
% Estimacao por metodo da resposta impulsiva do exemplo 4.6
clear; clc;

na = 3; nb = 4;
h(1) = 7.157039; h(2) = 9.491077; h(3) = 8.563889;
h(4) = 5.930506; h(5) = 2.845972; h(6) = 0.144611;

for i = 1:na
    for j = 1:na
        ha(i,j) = h(i+j-1);
    end
    haux1(i) = -h(i+3);
end
ha1 = inv(ha);
ah = ha1*haux1';
a = [ah(3) ah(2) ah(1)]

for j = 1:nb
    for i = 1:nb
        if j>i
            hb(j,i) = a(j-i);
        elseif j == i;
            hb(j,i) = 1;
        else
            hb(j,i) = 0;
        end
    end
end
haux2 = [0 h(1) h(2) h(3)];
b = (hb*haux2')'
