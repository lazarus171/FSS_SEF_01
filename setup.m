%%Script per scegliere i file contenenti i dati e la descrizione dei canali
%Pulisce il workspace per evitare interferenze di sorta
clear;
%Carica le strutture e le variabili dal file appositamente predisposto
load('struct_setup.mat');
%Apre la finestra di dialogo per scegliere il file dei dati
[f_name, f_path] = uigetfile('','Seleziona il file contenente le registrazioni dei dati');
%Imposta il valore della variabile DataPath in base alla scelta fatta
%controllando che la scelta sia valida
if f_name == 0
    return
else
    DataPath = fullfile(f_path, f_name);
end
%Apre la finestra di dialogo per scegliere il file dei canali proponendo il
%file dati come default
[f_name, f_path] = uigetfile('', 'Seleziona il file contenente la descrizione dei canali', DataPath);
%Imposta il valore della variabile ChanlocsPath in base alla scelta fatta
%controllando che la scelta sia valida
if f_name == 0
    return
else
    ChanlocsPath = fullfile(f_path, f_name);
end

%Pulisce il workspace dalle variabili ausiliarie utilizzate in questo
%script sia per evitare confusione sia per ridurre il consumo di risorse
clear('f_path', 'f_name');

