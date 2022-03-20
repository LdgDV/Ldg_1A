% Differential equation solver
% Scrittura delle EDO non dimensionali CALCOLO SIMBOLICO
% 
% Questo script serve a validare gli output della simulazione (come
% ulteriore verifica che si esegue)

% Scrittura EDO sfruttando il calcolo simbilico
syms A B x(t) z(t) T Y
Eq1 = diff(x,2) == A*((diff(x))^2+(diff(z))^2)^0.5*(diff(z)-B*diff(x));
Eq2 = diff(z,2) == 1 - A*((diff(x))^2+(diff(z))^2)^0.5*(diff(x)+B*diff(z));
[VF,Sbs] = odeToVectorField(Eq1,Eq2)
dinamica_aliante = matlabFunction(VF,'Vars',{T,Y,A,B})

% Soluzione EDO
B=0.06;
A=1.6;
tspan = [0,60];
t0 = [0,W0,0,U0];
[t,v_z] = ode45(@(T,Y)dinamica_aliante(T,Y,A,B),tspan,t0);

% Definizione di vettori per comparare la soluzione analitica e la
% soluzione del modello Simulink

    Xan = v_z(:,3);
    Zan = -v_z(:,1);


% Plot soluzioni
figure; 
plot(X,Z,'r','LineWidth',3)
hold on
plot(Xan,Zan,'g','LineWidth',1.5)
grid on
legend('Soluzione Simulink','Soluzione ODE')
xlabel('X [~]')
ylabel('Z [~]')
title('Confronto soluzioni modello simulink e modello analitico per \gamma_0=',num2str(gamma_0))