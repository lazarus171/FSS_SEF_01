function [data_ave, nave, triggerList] = trialAverage(data, triggerList, durata, pretrigger, bas, smpfq, soglia)
% Funzione che effettua l'averaging dei dati

%% Inizializzazioni
    nptdurata = round((durata/1000) * smpfq);
    nptpre = round((pretrigger/1000) * smpfq);
    data_ave = zeros(size(data, 1), nptdurata);
    
%% Costruzione della triggerList
%     triggerList = findTriggerList(triggerList);
    
%% Mediazione dei dati sui vari trial
    if isempty(bas) == 1
        bas(1) = 1;
        bas(2) = durata;
    else
        bas(1) = nptpre + (bas(1)/1000) * smpfq;
        bas(2) = nptpre + (bas(2)/1000) * smpfq;
    end
    for k=2 : length(triggerList) - 1
        if max(max(abs(data(:,triggerList(k)-nptpre : triggerList(k)-nptpre+durata)))) <= soglia
            data_ave = data_ave+data(:,triggerList(k)-nptpre+1 : triggerList(k)-nptpre+nptdurata) - mean(data(:,triggerList(k)-nptpre+bas(1) : triggerList(k)-nptpre+bas(2)),2);
        end
    end
    nave = length(triggerList)-2;
    data_ave = data_ave/nave;
end
