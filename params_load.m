%%Imposta i valori dei parametri
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
params.lambda = str2num(answer{1});
params.T0 = str2num(answer{2});
params.smpfq = str2num(answer{3});
%Pulisce il workspace dalle variabili utilizzate in questo script sia per
%evitare future confusioni sia per limitare l'utilizzo di memoria
clear('answer', 'definput', 'dims', 'dlgtitle', 'prompt');