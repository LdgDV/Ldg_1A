function [A,B,gamma_0,U0,W0,Max_val,Min_val] = LDG_1A_function(condizioni_iniziali)
% HELP LDG_1A
% Questa funzione restituisce i parametri (A,B,gamma_0,U0,WO) necessari per
% l'esecuzione della simulazione del modello in Simulink®.
% 
% INPUT:
% - condizioni_iniziali -> valore scalare 1 oppure valore scalare 2
%
% Nel caso di condizioni_iniziali==1 si assume gamma_0=+40º (richiamata)
% Nel caso di condizioni_iniziali==2 si assume gamma_0=-140º (discesa in
% volo rovescio)
%
%
% OUTPUT:
% - A -> fattore di carico normale al tempo t=0 -> A=0.5*rho*S*v_0^2*C_l/(mg)
% - B -> inverso dell'efficienza aerodinamica -> B=C_d/C_l
% - gamma_0 -> angolo di rampa delle condizioni iniziali
% - U0 -> velocità iniziale adimensionale \\ x 
% - W0 -> velocità iniziale adimensionale \\ z
%
%
% ESEMPIO (Command Window):
% [A,B,gamma_0,U0,W0] = LDG_1A_function(1)
% oppure
% [A,B,gamma_0,U0,W0] = LDG_1A_function(2)
%
%
%

% Controllo sull'input-----------------------------------------------------
if nargin==0
    
    fprintf('Inserire le condizioni iniziali:\n')
    fprintf('"1" per richiamata (gamma_0=+40 deg)\n')
    fprintf('"2" per discesa in volo rovescio (gamma_0=-140 deg)\n')
    a = input('condizioni_iniziali = ');
    condizioni_iniziali = a;
    
elseif nargin==1 && (condizioni_iniziali~=1 && condizioni_iniziali~=2)
    fprintf(2,'\n condizioni_iniziali puo'' assumere solo il valore 1 oppure il valore 2.\n\n')
    help LDG_1A
    
elseif nargin>1 || ~isreal(nargin)
    error('Troppi input, oppure condizioni_iniziali non e'' uno scalare reale ammissibile. Leggere l''help')
        
end
% fine controllo input-----------------------------------------------------


A = 1.6;    % A -> fattore di carico normale al tempo t=0 -> A=0.5*rho*S*v_0^2*C_l/(mg)
B = 0.06;   % B -> inverso dell'efficienza aerodinamica -> B=C_d/C_l

switch (condizioni_iniziali)
    
    case 1
        fprintf('\n')
        fprintf('Caso richiamata -> gamma_0 = +40 deg\n')
        gamma_0 = 40; %[deg]
        U0 = cos(gamma_0*pi/180);   % velocità iniziale adimensionale \\ x 
        W0 = -sin(gamma_0*pi/180);  % velocità iniziale adimensionale \\ z (z positivo verso il basso)
                
        % Info per i grafici
        Umax = 1.2;
        Umin = 0.2;
        
        Wmax = 0.7;
        Wmin = -0.7;
        
        Xmax = 47;
        Xmin = 0;
        
        Zmax = 0.5;
        Zmin = -3;
        
        n_normax = 2.2;
        n_normin = 0;
        
        n_tangmax = 0.2;
        n_tangmin = 0;
        
        % Vettore contentente i valori massimi e minimi per i grafici in Simulink
        Max_val = [Umax; Wmax; Xmax; Zmax; n_normax; n_tangmax];
        Min_val = [Umin; Wmin; Xmin; Zmin; n_normin; n_tangmin];
        
    case 2
        fprintf('\n')
        fprintf('Caso discesa in volo rovescio -> gamma_0 = -140 deg\n')
        gamma_0 = -140; %[deg]
        U0 = cos(gamma_0*pi/180);   % velocità iniziale adimensionale \\ x 
        W0 = -sin(gamma_0*pi/180);  % velocità iniziale adimensionale \\ z (z positivo verso il basso)
        
        % Info per i grafici
        Umax = 1.65;
        Umin = -0.8;
        
        Wmax = 1.4;
        Wmin = -1.1;
        
        Xmax = 45;
        Xmin = -0.2;
        
        Zmax = 0.5;
        Zmin = -3.4;
        
        n_normax = 4.3;
        n_normin = 0;
        
        n_tangmax = 0.3;
        n_tangmin = 0;
        
        % Vettore contentente i valori massimi e minimi per i grafici in Simulink
        Max_val = [Umax; Wmax; Xmax; Zmax; n_normax; n_tangmax];
        Min_val = [Umin; Wmin; Xmin; Zmin; n_normin; n_tangmin];
        
    otherwise 
        error('Leggere l''help\n')
end