%% Script che carica i dati secondo le scelte fatte nello script "setup.m"
%Carica la struct di descrizione dei canali
channel = load(ChanlocsPath).Channel;
%Carica il vettore degli istanti di tempo
time = load(DataPath).Time;
%Carica il vettore dei flags
ch_flag = load(DataPath).ChannelFlag;
%Carica la matrice dei dati registrati
data.eeg = load(DataPath).F;
%Carica nel campo Trigger la traccia che contiene il tracciato del segnale
%di riferimento degli stimoli(nel caso specifico il canale denominato STIM)
data.Trigger = data.eeg(1,:);

%% Imposta i valori di default per durata, pretrigger e basline in ms
%Prepara la lista dei nomi dei parametri
prompt = {'durata = tempo di___ in ms',...
    'pretrigger = tempo di___ in ms',...
    'bas 1 = istante iniziale della baseline - in ms',...
    'bas 2 = istante finale della basline - in ms'};
%Prepara il titolo della finestra di dialogo
dlgtitle = 'Regolazione valori';
%imposta le dimensioni delle caselle di testo della finestra
dims = [1 50];
%Prepara la lista dei valori di default
definput = {'1000', '1000', '100', '200'};
%Mostra la finestra di dialogo con le impostazioni sopra indicate
answer = inputdlg(prompt,dlgtitle,dims,definput);
%Imposta il valore dei parametri secondo le indicazioni ottenute tramite la
%finestra di dialogo
data.durata = str2num(answer{1});
data.pretrigger = str2num(answer{2});
data.bas(1) = str2num(answer{3});
data.bas(2) = str2num(answer{4});
%Pulisce il workspace dalle variabili utilizzate in questo script sia per
%evitare future confusioni sia per limitare l'utilizzo di memoria
clear('answer', 'definput', 'dims', 'dlgtitle', 'prompt');

