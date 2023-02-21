function triggerlist = findTriggerList(trigger)
% Funzione che costruisce la lista dei trigger, ovvero trova gli indici in
% corrispondenza dei trigger
soglia = 0.4 * max(trigger);
triggerlist = find(trigger >= soglia);

%restituisce una lista di valori ma non tiene conto della forma del segnale
%di trigger, per cui possono esserci valori consecutivi
%che formano un solo evento trigger
end
