function triggerlist = findTriggerList(trigger)
%% Funzione che costruisce la lista dei trigger.
% Definisce il valore da considerare come effettivo trigger
soglia = 0.4 * max(trigger);
%Trova una lista di indici in cui possono esserci valori consecutivi
%relativi ad un unico evento di trigger
trglst = find(trigger >= soglia);
answer = questdlg({'Potrebbero esserci indici consecutivi nella lista dei trigger.', 'Procedere alla semplificazione?'},...
    'Trigger List', 'Sì', 'No', 'No');
if answer == 'Sì'
    % Applica una semplificazione della lista ottenuta, restituisce una
    % lista di indici non consecutivi
   trglst = block_det(trglst);
end
%Restituisce la lista dei trigger
triggerlist = trglst;

end
