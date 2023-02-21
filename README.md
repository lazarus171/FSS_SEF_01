# FSS_SEF
 FSS algorithm for Matlab

13 febbraio 2023
-   impostato il repo "FSS_SEF_01" su github con i files del project con il 
    codice di Loli;
-   eliminato dal project tutti gli errori di file missing attraverso
    analisi delle dipendenze in Matlab;
-   sostituito il file "struttura.mat" con "struct_setup.mat" in cui ho
    salvato la versione vuota della struct indicata da Loli, ma anche le
    struct e i vettori che ho scoperto studiando i files dati ottenuti con 
    Brainstorm.

14 febbraio 2023
-   Creato la funzione "ch_filter.m" per la marcatura dei canali da
    eliminare
-   Modificato il main per utilizzare il filtro di cui sopra.
-   Rieseguito analisi delle dipendenze in Matlab 

21 febbraio 2023
-   Creato script 'data_load.m' per il caricamento dei dati nelle struct
    vuote caricate da 'setup.m'
-   Modificato le varie funzioni che utilizzano la trigger list in modo
    da calcolarla una sola volta e passare solo la lista già compilata.
-   La funzione 'findTriggerList.m' restituisce una lista di valori ma non 
    tiene conto della forma del segnale di trigger, per cui possono esserci
    valori consecutivi che formano un solo evento trigger.
-   Creato script 'params_load.m' per la scelta dei parametri e la loro
    memorizzazione nella struct 'params'
-   Modificato il 'main.m' in modo che lanci le funzioni sopra descritte
    anzichè calcolare valori più volte. Corretto fino alla riga 48 compresa
    (Calcolo della trigger list).