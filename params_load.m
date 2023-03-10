%% Imposta i valori dei parametri
%Prepara la lista dei nomi dei parametri
prompt = {'lambda = peso relativo rispetto alla curtosi',...
    'T0 = temperatura iniziale per il Simulated Annealing',...
    'smpfq = frequenza di campionamento'};
%Prepara il titolo della finestra di dialogo
dlgtitle = 'Input parametri';
%imposta le dimensioni delle caselle di testo della finestra
dims = [1 50];
%Prepara la lista dei valori di default
definput = {'1000', '617', '1200'};
%Mostra la finestra di dialogo con le impostazioni sopra indicate
answer = inputdlg(prompt,dlgtitle,dims,definput);
%Imposta il valore dei parametri secondo le indicazioni ottenute tramite la
%finestra di dialogo
params.lambda = str2double(answer{1});
params.T0 = str2double(answer{2});
params.smpfq = str2double(answer{3});

%% Impostazione dei dati per il calcolo del vincolo funzionale S1
prompt = {'maxSEF20 = (descrizione valore)',...
    'highSEF20 = (descrizione valore)',...
    'lowSEF20 = (descrizione valore)'};
%Prepara il titolo della finestra di dialogo
dlgtitle = 'Vincolo funzionale S1';
%imposta le dimensioni delle caselle di testo della finestra
dims = [1 50];
%Prepara la lista dei valori di default
definput = {'20', '1', '1'};
%Mostra la finestra di dialogo con le impostazioni sopra indicate
answer = inputdlg(prompt,dlgtitle,dims,definput);
%Imposta il valore dei parametri secondo le indicazioni ottenute tramite la
%finestra di dialogo
data.maxSEF20 = str2double(answer{1});
data.highSEF20 = str2double(answer{2});
data.lowSEF20 = str2double(answer{3});

%% Impostazione dei dati per il calcolo del vincolo funzionale M1
prompt = {'maxSEF22 = (descrizione valore)',...
    'highSEF22 = (descrizione valore)',...
    'lowSEF22 = (descrizione valore)'};
%Prepara il titolo della finestra di dialogo
dlgtitle = 'Vincolo funzionale M1';
%imposta le dimensioni delle caselle di testo della finestra
dims = [1 50];
%Prepara la lista dei valori di default
definput = {'22', '1', '1'};
%Mostra la finestra di dialogo con le impostazioni sopra indicate
answer = inputdlg(prompt,dlgtitle,dims,definput);
%Imposta il valore dei parametri secondo le indicazioni ottenute tramite la
%finestra di dialogo
data.maxSEF22 = str2double(answer{1});
data.highSEF22 = str2double(answer{2});
data.lowSEF22 = str2double(answer{3});

%Pulisce il workspace dalle variabili utilizzate in questo script sia per
%evitare future confusioni sia per limitare l'utilizzo di memoria
clear('answer', 'definput', 'dims', 'dlgtitle', 'prompt');