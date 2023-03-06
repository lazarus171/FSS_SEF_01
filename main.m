% Main con interfaccia grafica per l'algoritmo FSS
%
% Data Path è il percorso del file che contiene i dati eeg.
% In particolare deve contenere una struct di nome "data" che deve
% contenere i seguenti campi:
%   - durata:       1x1                         double
%   - pretrigger:   1x1                         double
%   - bas:          1x2                         double
%   - canali:       1 x Ncanali_eliminare       cell array
%   - eeg:          Ncanali x N_campionamenti   double
%   - Trigger:      1 x N_campionamenti         double
%   - maxSEF20:     1x1                         double
%   - lowSEF20:     1x1                         double
%   - highSEF20:    1x1                         double
%   - maxSEF22:     1x1                         double
%   - lowSEF22:     1x1                         double
%   - highSEF22:    1x1                         double
%
% Channel  Loc. Path è il percorso del file che contiene le coordinate dei
% canali eeg.

%% Interfaccia grafica
run setup.m;
%Controlla la validità della scelta dei files: se non sono stati scelti due
%files validi, abbandona il main con messaggio
if (isempty(ChanlocsPath)+isempty(DataPath)) ~= 0
    box = msgbox('Scelta non valida: procedura terminata.', 'Termina');
    return;
end


%% Caricamento dati
run data_load.m;


%% Parametri
%Carica i parametri nell'apposita struct con la possibilità di modificare i
%valori di default
run params_load.m;

%% Rimozione canali in due passaggi
%Primo passaggio: filtraggio canali sul vettore dei flags
[ch_flag] = ch_filter(ch_flag, channel);
%Secondo passaggio: eliminazione effettiva dei dati precedentemente marcati


%% Calcolo della TriggerList
TriggerList = findTriggerList(data.Trigger);

%%Pausa
goon = questdlg('Original code from now on. Continue?', 'Code info', 'Go', 'Stop', 'Stop');
if goon == 'Stop'
    return;
end
clear goon;
%% FSS
[AFS20, WSF20, FS20, RetroProjFS20, w20] = FSS_SEF(data.eeg, TriggerList, data.maxSEF20,...
    data.lowSEF20, data.highSEF20, data.durata, data.pretrigger, data.bas, params.smpfq, params.lambda, params.T0);
[AFS22, WSF22, FS22, RetroProjFS22, w22] = FSS_SEF(data.eeg, TriggerList, data.maxSEF22,...
    data.lowSEF22, data.highSEF22, data.durata, data.pretrigger, data.bas, params.smpfq, params.lambda, params.T0);


%% Plot EEG
[data_ave] = trialAverage(data.eeg/10, TriggerList, data.durata, data.pretrigger, data.bas, params.smpfq, 10^5);
t = (-data.pretrigger) : (1000/params.smpfq) : (data.durata - data.pretrigger - 1000/params.smpfq);
fig_eeg = figure();
plot(t, data_ave);
xlim([t(1) t(end)]);
ylim([-5 5]);
title('EEG');


%% Plot FS
[FS20ave] = trialAverage(FS20, TriggerList, data.durata, data.pretrigger, data.bas, params.smpfq, 2*10^12);
fig_FS20ave = figure();
plot(t, FS20ave);

[FS22ave] = trialAverage(FS22, TriggerList, data.durata, data.pretrigger, data.bas, params.smpfq, 2*10^12);
fig_FS22ave = figure();
plot(t, FS22ave);


%% Plot Retroprojected FS
[RetroProjFS20ave] = trialAverage(RetroProjFS20, TriggerList, data.durata, data.pretrigger, data.bas, params.smpfq, 2*10^12);
fig_RetroProjFS20ave = figure();
plot(t, RetroProjFS20ave);
title('FS20 eeg ave');
xlim([-data.pretrigger data.durata-data.pretrigger]);

[RetroProjFS22ave] = trialAverage(RetroProjFS22, TriggerList, data.durata, data.pretrigger, data.bas, params.smpfq, 2*10^12);
fig_RetroProjFS22ave = figure();
plot(t, RetroProjFS22ave);
title('FS22 eeg ave');
xlim([-data.pretrigger data.durata-data.pretrigger]);


%% Topoplot
fig_FS20topoplot = staticPlotN(data.canali, RetroProjFS20ave, data.maxSEF20, data.pretrigger, params.smpfq, ChanlocsPath, 0);
fig_FS22topoplot = staticPlotN(data.canali, RetroProjFS22ave, data.maxSEF22, data.pretrigger, params.smpfq, ChanlocsPath, 0);


%% Salvataggio figure
soggetto = DataPath(15:(end-4));
exportgraphics(fig_FS20ave, strcat('data_aveFS20_sogg', num2str(soggetto),'.pdf'), 'ContentType','vector');
exportgraphics(fig_RetroProjFS20ave, strcat('FS20_eeg_ave_sogg', num2str(soggetto),'.pdf'), 'ContentType','vector');
exportgraphics(fig_FS20topoplot, strcat('Topoplot_FS20_sogg', num2str(soggetto),'.pdf'), 'ContentType','vector');
exportgraphics(fig_FS22ave, strcat('data_aveFS22_sogg', num2str(soggetto),'.pdf'), 'ContentType','vector');
exportgraphics(fig_RetroProjFS22ave, strcat('FS22_eeg_ave_sogg', num2str(soggetto),'.pdf'), 'ContentType','vector');
exportgraphics(fig_FS22topoplot, strcat('Topoplot_FS22_sogg', num2str(soggetto),'.pdf'), 'ContentType','vector');