% Questa funzione serve solo per liberare il workspace e chiudere il
% progetto corrente.
uiwait(msgbox({'Sto chiudendo il progetto.', 'Ogni variabile sarà cancellata senza possibilità di recupero.'},'Shutdown','modal'));
clear;