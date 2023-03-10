function ret_struct = removeChannelData(data_struct, Flag)
%% Funzione che rimuove da Data i canali marcati con 0 nel Flag
% Estrae il vettore indici da eliminare dal Flag
    Indici_eliminare = find(Flag == 0);
% Elimina dalla matrice dati gli indici contenuti nel vettore sopra
% costruito
    data_struct.eeg(Indici_eliminare,:) = [];
% Restituisce la struttura dati modificata.
    ret_struct = data_struct;
    
end