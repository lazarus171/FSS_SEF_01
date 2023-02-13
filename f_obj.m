function [Res] = f_obj(w, whiteEEGc, triggerList, maxSEF, lowSEF, highSEF, durata_ms, pretrigger_ms, bas_ms, lambda, smpfq)
% Funzione obiettivo per FSS con vincolo funzionale S1 :
% f_obj=J(w'*whiteEEGc+lambda*RF_S1(w'*whiteEEGc)
    w = w/norm(w);
    evokedActivity = w' * whiteEEGc;
    
%% Calcolo della Kurtosi
    m2 = mean(evokedActivity.^2);
    m4 = mean(evokedActivity.^4);
    Kurtosis = m4/(m2^2)-3;
    
%% Calcolo del vincolo funzionale
    durata = round((durata_ms/1000)*smpfq;
    pretrigger = round((pretrigger_ms/1000)*smpfq);
    if isempty(bas_ms) == 0
        bas(1) = round(((pretrigger_ms + bas_ms(1))/1000) * smpfq;
        bas(2) = round(((pretrigger_ms + bas_ms(2))/1000) * smpfq;
    else
        bas = [];
    end
    sef = zeros(1, durata);
    maxSEF = round((maxSEF/1000) * smpfq);
    lowSEF = round((lowSEF/1000) * smpfq);
    highSEF = round((highSEF/1000) * smpfq);
    for k = 2:length(triggerList)-1
        if isempty(bas_ms) == 1
            sef = sef + evokedActivity((triggerList(k) - pretrigger + 1): (triggerList(k) - pretrigger + durata));
        else
            sef = sef + evokedActivity((triggerList(k) - pretrigger + 1) : (triggerList(k) - pretrigger + durata)) - mean(evokedActivity((triggerList(k) + bas(1)) : (triggerList(k) + bas(2))));
        end
    end
    nave = length(triggerList) - 2;
    sef = sef/nave;
    if isempty(bas_ms) == 0
        sef = sef - mean(sef(bas(1) : sef(bas(2))));
    end
    absSef = abs(sef);
    windows = ((maxSEF -  lowSEF + pretrigger) : (maxSEF + highSEF + pretrigger));
    if isempty(bas_ms) == 0
        indiceSEF = sum(absSef(windows), 2) - sum(absSef(bas(1) : bas(2)),2);
    else
        indiceSEF = sum(absSef(windows), 2);
    end
    
    
%% Somma tra Kurtosi e vincolo funzionale
    Res = Kurtosis + lambda * indiceSEF;
    
end
