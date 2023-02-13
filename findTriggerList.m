function triggerlist = findTriggerList(trigger)
% Funzione che costruisce la lista dei trigger, ovvero trova gli indici in
% corrispondenza dei trigger

    soglia = 0.4 * max(trigger);
    triggerlist = find(trigger >= soglia;

end
