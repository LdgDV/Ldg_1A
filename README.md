# Ldg_1A
DV - Lavoro di gruppo 1A 
Gruppo 06
Aurora Tulli e Stephan Ciobanu

Consigliamo di scaricare tutto il pacchetto ed eseguire solamente lo script main_ldg1a.m su Matlab (tutti i file .m devono comunque essere salvati nella directory di lavoro).

Lista di file pubblicati:

1) main_ldg1a.m

Questo è lo script principale che consente di ottenere tutti i risultati ed i grafici della simulazione della dinamica (semplificata) di un aliante nel piano verticale eseguento il modello Simulink senza aprire Simulink.

2) LDG_1A_function.m

Questa funzione, in base all'input, definisce le condizioni iniziali per la simulazione.

4) plot_LDG_1A.m

Questo script grafica i risultati della simulazione

6) Equilibrio_degli_stati_LDG_1A.m

Questo script calcola i valori stazionari delle grandezze in gioco, si basa sulle ODE che descrivono il problema.

8) ODE2ndorder.m

Questo script, tramite il calcolo simbolico, calcola la soluzione delle ODE e la confronta con la soluzione di Simulink, è stato utilizzato per validare gli output di simulink.

10) grafici_interattivi.m

Script che grafica gli stati U,W in funzione del tempo realizzando un'animazione.

12) Ldg_1a.slx

È il modello simulink.



Gli altri file sono immagini, GIF o video per la visualizzazione ed interpretazione dei risultati del modello in Simulink.


Se si decide di non eseguire lo script main, eseguire i vari script nel seguente ordine:
1) LDG_1A_function.m
2) Ldg_1a.slx (eseguire la simulazione su Simulink®)
3) plot_LDG_1A.m
4) Equilibrio_degli_stati_LDG_1A.m
5) ODE2ndorder.m (se si vogliono validare gli output di Simulink)
6) grafici_interattivi.m (se si vuole salvare una gif degli stati U,W come curva dipendente dal parametro T (tempo))
