% MAIN
%
% Ldg_1A project (Gruppo 06)
% Questo script cerca di avere un approccio user-friendly per mostrare 
% i risultati della simulazione della dinamica di un aliante nel piano
% verticale.
% 
% I risultati verranno calcolati sequenzialmente e l'utente avrà la
% possibilità di scegliere se plottare i risultati o meno.
%
% © Stephan Ciobanu, Aurora Tulli
% Marzo 2022.

% INIZIO SCRIPT
% Consigliamo di scommentare le seguenti 3 righe:
% clear 
% clc
% close all
%-------------------------------------------------------------------------%
% creazione di un finestra di dialogo con l'utente
answer = questdlg('Per quale condizione iniziale vuole eseguire la simulazione?', ...
	'Simulazione semplificata volo di un aliante nel piano verticale', ...
	'Richiamata','Discesa in volo rovescio','Nessuna delle due','Nessuna delle due');
% Handle response
switch answer
    case 'Richiamata'
        disp([answer ' la simulazione è in fase di avvio'])
        condizioni_iniziali = 1;
    case 'Discesa in volo rovescio'
        disp([answer ' la simulazione è in fase di avvio'])
        condizioni_iniziali = 2;
    case 'Nessuna delle due'
        error('Simulazione non eseguita.')
end
%-------------------------------------------------------------------------%
% Definizione parametri e condizioni iniziali
tic
[A,B,gamma_0,U0,W0,Max_val,Min_val] = LDG_1A_function(condizioni_iniziali);
fprintf('Tempo trascorso per la definizione dei parametri e delle condizioni iniziali: \n')
toc
fprintf('\n')
%-------------------------------------------------------------------------%
% Simulazione in simulink
fprintf('Inizio simulazione\n')
tic
out = sim('Ldg_1a');
fprintf('Tempo trascorso per la simulazione in Simulink: \n')
toc
fprintf('\n')
%-------------------------------------------------------------------------%
% PLOT - dialogo con l'utente
answer2 = questdlg('Vuole graficare i risultati della simulazione?', ...
	'Opzione Plot', ...
	'Si','No','No');
% Handle response
switch answer2
    case 'Si'
        tic
        plot_LDG_1A
        fprintf('Tempo trascorso per plottare i risultati: \n')
        toc
        fprintf('\n')
    case 'No'
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
end
%-------------------------------------------------------------------------%
% Equilibrio degli stati - dialogo con l'utente
answer3 = questdlg('Vuole paragonare i valori stazionari degli stati U,W con quelli della simulazione?', ...
	'Analisi dei valori di equilibrio della velocità', ...
	'Si','No','No');
% Gestione risposta
switch answer3
    case 'Si'
        tic
        Equilibrio_degli_stati_LDG_1A
        fprintf('Tempo trascorso per calcolare la soluzione stazionaria: \n')
        toc
        fprintf('\n')
        questdlg('I risultati sono stampati sul Command Window', ...
            'Calcolo eseguito con successo', ...
            'Ok','Ok');
        clear ans
    case 'No'
        fprintf(2,'Punto d) NON ESEGUITO \n')
end
%-------------------------------------------------------------------------%
% Equilibrio degli stati - dialogo con l'utente
answer4 = questdlg('Vuole confrontare gli output della simulazione con la soluzione analitica delle ODEs?', ...
	'Validazione output del modello Simulink', ...
	'Si','No','No');
% Gestione risposta
switch answer4
    case 'Si'
        tic
        ODE2ndorder
        fprintf('Tempo trascorso per la risoluzione delle ODEs con il calcolo simbolico: \n')
        toc
        fprintf('\n')
    case 'No'
        fprintf(2,'Validazione risultati NON ESEGUITA\n')
end
%-------------------------------------------------------------------------%
% Grafici interattivi - dialogo con l'utente
answer5 = questdlg('Vuole visualizzare i grafici interattivi degli output di Simulink?', ...
	'Grafici interattivi', ...
	'Si','No','No');
% Gestione risposta
switch answer5
    case 'Si'
        list = {'Traiettoria','Odografa','Fattore di carico normale',...                   
                'Fattore di carico tangenziale'};
        [indx,tf] = listdlg('PromptString',{'Selezioni il grafico che vuole visualizzare',...
                'Si può effettuare una sola selezione alla volta.',''},...
                'SelectionMode','single','ListString',list);  
    case 'No'
        indx = 0;
        fprintf(2,'Grafici interattivi non plottati. FINE SCRIPT  \n')
end

switch (indx)
    case 1
        for i = 1:length(X)
            plot(X(1:i),Z(1:i))
            xlabel('X [~]')
            ylabel('W [~]')
            axis([min(X) max(X) min(Z) max(Z)])
            title(['Traiettoria per t = ',num2str(out.tout(i))])
            hold on
            plot(X(i),Z(i),'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','r')
            pause(0.0001)
            frame = getframe(1);
            img = frame2im(frame);
            [imgind,cm]=rgb2ind(img,256);
            if i==1
                imwrite(imgind,cm,'Traiettoria.gif','gif','DelayTime',0,'loopcount',inf);
            else
                imwrite(imgind,cm,'Traiettoria.gif','gif','DelayTime',0,'writemode','append');
            end
            hold off
        end
        pause
    case 2
        for i = 1:length(X)
            plot(U(1:i),W(1:i))
            xlabel('U [~]')
            ylabel('W [~]')
            axis([min(U) max(U) min(W) max(W)])
            title(['Odografa per t = ',num2str(out.tout(i))])
            hold on
    
            plot(U(i),W(i),'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','r')
    
            pause(0.0001)
            frame = getframe(1);
            img = frame2im(frame);
            [imgind,cm]=rgb2ind(img,256);
    
            if i==1
                imwrite(imgind,cm,'Odo+40_simple.gif','gif','DelayTime',0,'loopcount',inf);
            else
                imwrite(imgind,cm,'Odo+40_simple.gif','gif','DelayTime',0,'writemode','append');
            end
    
            hold off
        end
        pause
    case 3
        for i = 1:length(X)
            plot(out.tout(1:i),out.n_norm.Data(1:i))
            xlabel('T [~]')
            ylabel('n_n [~]')
            axis([0 60 min(out.n_norm.Data) max(out.n_norm.Data)])
            title(['Fattore di carico normale per t = ',num2str(out.tout(i))])
            hold on
            plot(out.tout(i),out.n_norm.Data(i),'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','r')
            pause(0.0001)
            frame = getframe(1);
            img = frame2im(frame);
            [imgind,cm]=rgb2ind(img,256);
            if i==1
                imwrite(imgind,cm,'n_normale.gif','gif','DelayTime',0,'loopcount',inf);
            else
                imwrite(imgind,cm,'n_normale.gif','gif','DelayTime',0,'writemode','append');
            end
            hold off
        end
        pause
    case 4
        for i = 1:length(X)
            plot(out.tout(1:i),out.n_tang.Data(1:i))
            xlabel('T [~]')
            ylabel('n_t [~]')
            axis([0 60 min(out.n_tang.Data) max(out.n_tang.Data)])
            title(['Fattore di carico tangenziale per t = ',num2str(out.tout(i))])
            hold on
            plot(out.tout(i),out.n_tang.Data(i),'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','r')
            pause(0.0001)
            frame = getframe(1);
            img = frame2im(frame);
            [imgind,cm]=rgb2ind(img,256);
            if i==1
                imwrite(imgind,cm,'n_tangenziale.gif','gif','DelayTime',0,'loopcount',inf);
            else
                imwrite(imgind,cm,'n_tangenziale.gif','gif','DelayTime',0,'writemode','append');
            end
            hold off
        end
        pause
    otherwise
        fprintf(2,'Grafici interattivi non plottati. FINE SCRIPT  \n')
end
%---------------FINE-MAIN-------------------------------------------------%