%%Script per scegliere i file contenenti i dati e la descrizione dei canali
%Pulisce il workspace per evitare interferenze di sorta
clear;
%Carica le strutture e le variabili dal file appositamente predisposto
load('struct_setup.mat');
%Apre la finestra di dialogo per scegliere il file dei dati; il file
%proposto di default serve x sveltire le operazioni di test
[f_name, f_path] = uigetfile('','Seleziona il file contenente le registrazioni dei dati',...
    'D:\brainstorm_db\TutorialCMC\data\Subject01\SubjectCMC_notch_02\data_block001.mat');
%Imposta il valore della variabile DataPath in base alla scelta fatta
%controllando che la scelta sia valida
if f_name == 0
    return
else
    DataPath = fullfile(f_path, f_name);
end
%Apre la finestra di dialogo per scegliere il file dei canali; il file
%proposto di default serve x sveltire le operazioni di test
[f_name, f_path] = uigetfile('', 'Seleziona il file contenente la descrizione dei canali',...
    'D:\brainstorm_db\TutorialCMC\data\Subject01\SubjectCMC_notch_02\channel_ctf_acc1.mat');
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

