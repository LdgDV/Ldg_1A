% Equilibrio degli stati U,W
%
% all'equilibrio si impone: 
% 0 = A*(U^2+W^2)^(0.5)*(W-B*U)
% 0 = 1 - A*(U^2+W^2)^0.5*(U+B*W)

% Definizione anonymous function
F = @(u) [A*(u(1).^2+u(2).^2).^(0.5).*(u(2)-B*u(1)); 1-A*(u(1).^2+u(2).^2).^0.5.*(u(1)+B*u(2))];
      
% Punto iniziale per risolvere l'eq. non lineare
eps = 10^-1;
P_iniziale = [U(end)+eps;W(end)+eps];

% Opzioni per vedere le iterazioni:
options = optimoptions('fsolve','Display','iter');

% Risoluzione sistema: (x(1)->U_analitica ; x(2)->V_analitica)
[x,fval] = fsolve(F,P_iniziale,options)

% Velocità adimensionale analitica:
v_an = (x(1)^2+x(2)^2)^0.5;
gamma_an = atan(-x(2)/x(1));
gamma_an_deg = gamma_an*180/pi;

% Confronto con risultati dalla simulazione @ T=10s: 
% errore = valore sim - valore analitico
pos10 = find(out.tout==10);
errU10 = out.U.Data(pos10)-x(1);
errW10 = out.W.Data(pos10)-x(2);
errV10 = (out.U.Data(pos10)^2+out.W.Data(pos10)^2)^(0.5)-v_an;
errG10 = atan(-out.W.Data(pos10)/out.U.Data(pos10))-gamma_an;

% Confronto con risultati dalla simulazione @ T=60s: 
% errore = valore sim - valore analitico
errU = U(end)-x(1);
errW = W(end)-x(2);
errV = (U(end)^2+W(end)^2)^(0.5)-v_an;
errG = atan(-W(end)/U(end))-gamma_an;

% Stampa dei risultati (errori) @ T=10s
fprintf('La differenza errU = U(simulazione) - U(analitico) @ T=10s è pari a:\n')
fprintf('errU = %6.5f\n',errU10)
fprintf('\n')
fprintf('La differenza errW = W(simulazione) - W(analitico) @ T=10s è pari a:\n')
fprintf('errW = %6.5f\n',errW10)
fprintf('\n')
fprintf('La differenza errV = V(simulazione) - V(analitico) @ T=10s è pari a:\n')
fprintf('errV = %6.5f\n',errV10)
fprintf('\n')
fprintf('La differenza errG = G(simulazione) - G(analitico) @ T=10s è pari a:\n')
fprintf('errG = %6.5f\n',errG10)

% Stampa dei risultati (errori) @ T=60s
fprintf('\n')
fprintf('La differenza errU = U(simulazione) - U(analitico) @ T=60s è pari a:\n')
fprintf('errU = %6.5f\n',errU)
fprintf('\n')
fprintf('La differenza errW = W(simulazione) - W(analitico) @ T=60s è pari a:\n')
fprintf('errW = %6.5f\n',errW)
fprintf('\n')
fprintf('La differenza errV = V(simulazione) - V(analitico) @ T=60s è pari a:\n')
fprintf('errV = %6.5f\n',errV)
fprintf('\n')
fprintf('La differenza errG = G(simulazione) - G(analitico) @ T=60s è pari a:\n')
fprintf('errG = %6.5f\n',errG)