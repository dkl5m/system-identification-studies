%% Exemplo 5.3
% Estimador dos minimos quadrados recursivo
% Planta de segunda ordem
clear; clc;

nit = input(' Quantas iteracoes? ');
u(i) = 0;
for i = 1:nit                            % Entrada e ruido
    if rand > 0.5
        u(i) = 1;
    else
        u(i) = -1;
    end
end
e = u*0.01;
p = 1000*eye(4,4); teta = [0;0;0;0];    % Condicoes iniciais
for t = 1:4
    y(i) = 0; erro(t) = 0;
    a1(t) = teta(1); a2(t) = teta(2);
    b0(t) = teta(3); b1(t) = teta(4);
end
for t = 4:nit
    y(t) = 1.5144 * y(t-1) - 0.5506 * y(t-2) + ...
        0.599 * u(t-1) + 0.163 * u(t-2) + e(t);
    fi = [-y(t-1); -y(t-2); u(t-1); u(t-2)];
    erro(t) = y(t) - teta'*fi;          % Erro de estimacao
    k = p*fi/ (1+fi'*p*fi);             % Ganho do estimador
    teta = teta + k*erro(t);            % Vetor de parametros
    p = (p - k*fi'*p);                  % Matriz de covariancia
    a1(t) = teta(1); a2(t) = teta(2);
    b0(t) = teta(3); b1(t) = teta(4);
end

t = 1:nit;                              % Parametros estimados
subplot(221), plot(t,a1(t)), title('a1'), xlabel('amostragem');
subplot(222), plot(t,a2(t)), title('a2'), xlabel('amostragem');
subplot(223), plot(t,b0(t)), title('b0'), xlabel('amostragem');
subplot(224), plot(t,b1(t)), title('b1'), xlabel('amostragem');

%% Exemplo 5.4
% Sequencia binaria pseudo-aleatoria
clear all;
delta = input('Intervalo de integracao delta t = ');