% Risultati simulazione LDG_1A + PLOT
% Questo script si estrae gli output della simulazione condotta in
% Simulink e crea nuove variabili nel workspace per costruire i grafici per
% la relazione LDG_1A.
%
% I grafici commentati con "%" non sono da esportare ma hanno lo scopo di
% comprendere la dinamica del moto dell'aliante e di verificare errori nel modello.

% Estrapolazione OUTPUT
% velocità
U = out.U.Data;
W = out.W.Data;

% traiettoria
X = out.X.Data;
Z = out.Z.Data;

% fattore di carico
% normale
n_n = out.n_norm.Data;
% tangenziale
n_t = out.n_tang.Data;

% tempo di simulazione
t = out.tout;

% cerco la posizione di T=10 secondi
pos = find(t==10);

% PLOT

% U vs t
% figure;
% plot(t,U,'LineWidth',3)
% grid on
% legend('U=U(t)')
% title('Grafico della velocità longitudinale in funzione del tempo di simulazione')
% xlabel('tempo t [s]')
% ylabel('Velocità U [~]')

% W vs t
% figure;
% plot(t,W,'LineWidth',3)
% grid on
% legend('W=W(t)')
% title('Grafico della velocità verticale in funzione del tempo di simulazione')
% xlabel('tempo t [s]')
% ylabel('Velocità W [~]')

% U vs W
figure;
plot(U,W,'LineWidth',3)
grid on
hold on
plot(U(pos),W(pos),'o','MarkerSize',10)
plot(U(end),W(end),'*','MarkerSize',8)
legend('U=U(W)','U,W @ T=10s','stazionario')
title('Odografa del moto dell''aliante')
xlabel('Velocità U [~]')
ylabel('Velocità W [~]')

% X vs t
% figure;
% plot(t,X,'LineWidth',3)
% grid on
% legend('X=X(t)')
% title('Posizione del baricentro lungo X in funzione del tempo di simulazione')
% xlabel('tempo t [s]')
% ylabel('X [~]')

% W vs t
% figure;
% plot(t,Z,'LineWidth',3)
% grid on
% legend('Z=Z(t)')
% title('Posizione del baricentro lungo Z in funzione del tempo di simulazione')
% xlabel('tempo t [s]')
% ylabel('Z [~]')

% X vs Z
figure;
plot(X,Z,'LineWidth',3)
hold on
xline(X(pos),'r') %Questo comando necessita Matlab R2018b o successive versioni
grid on
%axis equal
legend('Z=Z(X)','T=10s')
title('Traiettoria')
xlabel('X [~]')
ylabel('Z [~]')

% fattore di carico normale
% n_norm vs t
figure;
plot(t,n_n,'LineWidth',3)
grid on
legend('n_n=n_n(t)')
title('Fattore di carico normale in funzione del tempo di simulazione')
xlabel('tempo t [s]')
ylabel('n_{norm} [~]')

% n_tang vs t
figure;
plot(t,n_t,'LineWidth',3)
grid on
legend('n_t=n_t(t)')
title('Fattore di carico tangenziale in funzione del tempo di simulazione')
xlabel('tempo t [s]')
ylabel('n_{tang} [~]')