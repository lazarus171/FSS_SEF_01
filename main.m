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
%Carica la struct di descrizione dei canali
channel = load(ChanlocsPath).Channel;
%Carica il vettore degli istanti di tempo
time = load(DataPath).Time;
%Carica il vettore dei flags
ch_flag = load(DataPath).ChannelFlag;
%Carica la matrice dei dati registrati
data.eeg = load(DataPath).F;
%Calcola la durata in base ai valori presenti nel vettore degli istanti di
%tempo
data.durata = time(size(time,2))-time(1);
%Calcola il tempo di pretrigger in base ai valori presenti nel vettore
%degli istanti di tempo
data.pretrigger = time(~time)-time(1);


%% Parametri
lambda = 1000; %Peso relativo del vincolo funzionale rispetto alla Curtosi
T0 = 2560; %Temperatura iniziale per Simulated Annealing
smpfq = 5000; %Frequenza campionamento eeg e Trigger


%% Rimozione canali in due passaggi
%Primo passaggio: filtraggio canali sul vettore dei flags
[ch_flag, data.canali] = ch_filter(ch_flag, channel);
%Secondo passaggio: eliminazione effettiva dei dati precedentemente marcati

%% Calcolo della TriggerList
TriggerList = findTriggerList(data.Trigger);


%% FSS
[AFS20, WSF20, FS20, RetroProjFS20, w20] = FSS_SEF(data.eeg, TriggerList, data.maxSEF20, data.lowSEF20, data.highSEF20, data.durata, data.pretrigger, data.bas, smpfq, lambda, T0);
[AFS22, WSF22, FS22, RetroProjFS22, w22] = FSS_SEF(data.eeg, TriggerList, data.maxSEF22, data.lowSEF22, data.highSEF22, data.durata, data.pretrigger, data.bas, smpfq, lambda, T0);


%% Plot EEG
[data_ave] = trialAverage(data.eeg/10, data.Trigger, data.durata, data.pretrigger, data.bas, smpfq, 10^5);
t = (-data.pretrigger) : (1000/smpfq) : (data.durata - data.pretrigger - 1000/smpfq);
fig_eeg = figure();
plot(t, data_ave);
xlim([t(1) t(end)]);
ylim([-5 5]);
title('EEG');


%% Plot FS
[FS20ave] = trialAverage(FS20, data.Trigger, data.durata, data.pretrigger, data.bas, smpfq, 2*10^12);
fig_FS20ave = figure();
plot(t, FS20ave);

[FS22ave] = trialAverage(FS22, data.Trigger, data.durata, data.pretrigger, data.bas, smpfq, 2*10^12);
fig_FS22ave = figure();
plot(t, FS22ave);


%% Plot Retroprojected FS
[RetroProjFS20ave] = trialAverage(RetroProjFS20, data.Trigger, data.durata, data.pretrigger, data.bas, smpfq, 2*10^12);
fig_RetroProjFS20ave = figure();
plot(t, RetroProjFS20ave);
title('FS20 eeg ave');
xlim([-data.pretrigger data.durata-data.pretrigger]);

[RetroProjFS22ave] = trialAverage(RetroProjFS22, data.Trigger, data.durata, data.pretrigger, data.bas, smpfq, 2*10^12);
fig_RetroProjFS22ave = figure();
plot(t, RetroProjFS22ave);
title('FS22 eeg ave');
xlim([-data.pretrigger data.durata-data.pretrigger]);


%% Topoplot
fig_FS20topoplot = staticPlotN(data.canali, RetroProjFS20ave, data.maxSEF20, data.pretrigger, smpfq, ChanlocsPath, 0);
fig_FS22topoplot = staticPlotN(data.canali, RetroProjFS22ave, data.maxSEF22, data.pretrigger, smpfq, ChanlocsPath, 0);


%% Salvataggio figure
soggetto = DataPath(15:(end-4));
exportgraphics(fig_FS20ave, strcat('data_aveFS20_sogg', num2str(soggetto),'.pdf'), 'ContentType','vector');
exportgraphics(fig_RetroProjFS20ave, strcat('FS20_eeg_ave_sogg', num2str(soggetto),'.pdf'), 'ContentType','vector');
exportgraphics(fig_FS20topoplot, strcat('Topoplot_FS20_sogg', num2str(soggetto),'.pdf'), 'ContentType','vector');
exportgraphics(fig_FS22ave, strcat('data_aveFS22_sogg', num2str(soggetto),'.pdf'), 'ContentType','vector');
exportgraphics(fig_RetroProjFS22ave, strcat('FS22_eeg_ave_sogg', num2str(soggetto),'.pdf'), 'ContentType','vector');
exportgraphics(fig_FS22topoplot, strcat('Topoplot_FS22_sogg', num2str(soggetto),'.pdf'), 'ContentType','vector');