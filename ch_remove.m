%% Rimuove dalle varie strutture i valori/vettori marcati con 0 nel ch_flag
answer = questdlg('Procedere al filtraggio dei canali?', 'Filtering', 'Sì', 'No', 'No');
if answer == 'No'
    return;
end
%Primo passaggio: filtraggio canali sul vettore dei flags
[ch_flag] = ch_filter(ch_flag, channel);

answer = questdlg('Procedere ad eliminare i canali filtrati?', 'Removing', 'Sì', 'No', 'No');
if answer == 'No'
    return;
end

% Estrae il vettore indici da eliminare dal Flag
remove_idx = find(ch_flag == 0);

% Elimina dalla matrice dati gli indici contenuti nel vettore sopra
% costruito
data.eeg(remove_idx,:) = [];

% Elimina dalla struct dei canali gli indici contenuti nel vettore
% remove_idx
channel(:, remove_idx) = [];

%Elimina dal vettore ch_flag tutto quanto è stato marcato con 0
ch_flag(remove_idx) = [];

%Ripulisce il workspace dal vettore ausiliario utilizzato
clear('remove_idx', 'answer');