function Locs = removeChannelLocs(Locs, Canali_eliminare)
% Funzione che rimuove da Locs i canali presenti in Canali_eliminare

    Indici_eliminare = [];
    
    for i=1:length(Canali_eliminare)
        Indici_eliminare = cat(1, Indici_eliminare, find(strcmp({Locs.labels}, Canali_eliminare(i))==1));
    end
    
    Locs(Indici_eliminare) = [];
    
end
