%% Exemplo 4.3
% Estimacao de modelo 2a ordem por metodo Mollenkamp

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