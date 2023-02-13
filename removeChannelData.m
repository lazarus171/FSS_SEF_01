function Data = removeChannelData(Data, Channel_path)
% Funzione che rimuove da Data i canali presenti nel file avente path
% 'Channel_path', la cui label compare in Data.canali

%% Caricamento del file il cui path è 'Channel_path'
    chanlocs = load(Channel_path).chanlocs;

%% Rimozione dei canali indicati in Data.canali
    Indici_eliminare = [];
    for i = 1 : length(Data.canali)
        Indici_eliminare = cat(1, Indici_eliminare, find(strcmp({chanlocs.labels}, Data.canali(i))==1;
    end
    Data.eeg(Indici_eliminare,:) = [];
    
end