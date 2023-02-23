function Flag = ch_filter(ch_Flag, ch_struct)
%%Filtra i canali da eliminare nel ch_flag 
%  Segna con uno 0 i canali non utili nel ch_flag
%  Per semplicità si utilizzano due stringhe per i possibili nomi di canali
%  da mantenere, tutti gli altri sono considerati da eliminare
%Comunicazioni per l'utente
uiwait(msgbox({'Questa funzione marca con uno zero il flag', 'di tutti i canali NON di tipo MEG o EEG', 'mantenendo eventuali zeri già presenti.'},'Attenzione!','warn', 'modal'));
%Lista dei tipi di canale da marcare
keep = {'MEG', 'EEG'};
%Ciclo di scansione del ch_flag
for i = 1 : length(ch_Flag)
    s1 = ch_struct(i).Type;
    %Condizione di marcatura
    marker = sum(strcmp(s1, keep));
    %Marca il flag moltiplicando il marcatore per il valore del flag stesso
    %per mantenere gli zeri eventualmente già presenti(es. un canale già
    %marcato in altra sede)
    ch_Flag(i) = marker * ch_Flag(i);
end
Flag = ch_Flag;
end

