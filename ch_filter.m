function Flag = ch_filter(ch_Flag, ch_struct)
%%Filtra i canali da eliminare nel ch_flag 
%  Segna con uno 0 i canali non utili nel ch_flag
%  Per semplicità si utilizzano due stringhe per i possibili nomi di canali
%  da mantenere, tutti gli altri sono considerati da eliminare
keep = {'MEG', 'EEG'};
%Ciclo di scansione del ch_flag
for i = 1 : length(ch_Flag)
    %Ciclo di scansione della lista da mantenere
    for j = 1 : length(keep)
        %Imposta il flag del canale sul risultato della comparazione fra le
        %stringhe
        if strcmp(ch_struct(i).Type, keep(j))
            ch_Flag(i) = 1;
        end
    end
end
Flag = ch_Flag;
end

