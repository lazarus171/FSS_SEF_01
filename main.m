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
prompt = {'Data Path','Channel Loc. Path'};
dims = [1,40].*ones(size(prompt,2),1);
definput = {'data_soggetto_6.mat','chanloc.mat'};
InputWindow = inputdlg(prompt, 'FSS - Input' ,dims, definput);
if size(InputWindow, 1) == 0
    return;
end


%% Caricamento dati
DataPath = InputWindow{1};
ChanlocsPath = InputWindow{2};
Data = load(DataPath).data;


%% Parametri
lambda = 1000; %Peso relativo del vincolo funzionale rispetto alla Curtosi
T0 = 2560; %Temperatura iniziale per Simulated Annealing
smpfq = 5000; %Frequenza campionamento eeg e Trigger


%% Rimozione canali
Data = removeChannelData(Data, ChanlocsPath);


%% Calcolo della TriggerList
TriggerList = findTriggerList(Data.Trigger);


%% FSS
[AFS20, WSF20, FS20, RetroProjFS20, w20] = FSS_SEF(Data.eeg, TriggerList, Data.maxSEF20, Data.lowSEF20, Data.highSEF20, Data.durata, Data.pretrigger, Data.bas, smpfq, lambda, T0);
[AFS22, WSF22, FS22, RetroProjFS22, w22] = FSS_SEF(Data.eeg, TriggerList, Data.maxSEF22, Data.lowSEF22, Data.highSEF22, Data.durata, Data.pretrigger, Data.bas, smpfq, lambda, T0);


%% Plot EEG
[data_ave] = trialAverage(Data.eeg/10, Data.Trigger, Data.durata, Data.pretrigger, Data.bas, smpfq, 10^5);
t = (-Data.pretrigger) : (1000/smpfq) : (Data.durata - Data.pretrigger - 1000/smpfq);
fig_eeg = figure();
plot(t, data_ave);
xlim([t(1) t(end)]);
ylim([-5 5]);
title('EEG');


%% Plot FS
[FS20ave] = trialAverage(FS20, Data.Trigger, Data.durata, Data.pretrigger, Data.bas, smpfq, 2*10^12);
fig_FS20ave = figure();
plot(t, FS20ave);

[FS22ave] = trialAverage(FS22, Data.Trigger, Data.durata, Data.pretrigger, Data.bas, smpfq, 2*10^12);
fig_FS22ave = figure();
plot(t, FS22ave);


%% Plot Retroprojected FS
[RetroProjFS20ave] = trialAverage(RetroProjFS20, Data.Trigger, Data.durata, Data.pretrigger, Data.bas, smpfq, 2*10^12);
fig_RetroProjFS20ave = figure();
plot(t, RetroProjFS20ave);
title('FS20 eeg ave');
xlim([-Data.pretrigger Data.durata-Data.pretrigger]);

[RetroProjFS22ave] = trialAverage(RetroProjFS22, Data.Trigger, Data.durata, Data.pretrigger, Data.bas, smpfq, 2*10^12);
fig_RetroProjFS22ave = figure();
plot(t, RetroProjFS22ave);
title('FS22 eeg ave');
xlim([-Data.pretrigger Data.durata-Data.pretrigger]);


%% Topoplot
fig_FS20topoplot = staticPlotN(Data.canali, RetroProjFS20ave, Data.maxSEF20, Data.pretrigger, smpfq, ChanlocsPath, 0);
fig_FS22topoplot = staticPlotN(Data.canali, RetroProjFS22ave, Data.maxSEF22, Data.pretrigger, smpfq, ChanlocsPath, 0);


%% Salvataggio figure
soggetto = DataPath(15:(end-4));
exportgraphics(fig_FS20ave, strcat('data_aveFS20_sogg', num2str(soggetto),'.pdf'), 'ContentType','vector');
exportgraphics(fig_RetroProjFS20ave, strcat('FS20_eeg_ave_sogg', num2str(soggetto),'.pdf'), 'ContentType','vector');
exportgraphics(fig_FS20topoplot, strcat('Topoplot_FS20_sogg', num2str(soggetto),'.pdf'), 'ContentType','vector');
exportgraphics(fig_FS22ave, strcat('data_aveFS22_sogg', num2str(soggetto),'.pdf'), 'ContentType','vector');
exportgraphics(fig_RetroProjFS22ave, strcat('FS22_eeg_ave_sogg', num2str(soggetto),'.pdf'), 'ContentType','vector');
exportgraphics(fig_FS22topoplot, strcat('Topoplot_FS22_sogg', num2str(soggetto),'.pdf'), 'ContentType','vector');