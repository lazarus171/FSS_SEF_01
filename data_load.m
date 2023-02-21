%%Script che carica i dati secondo le scelte fatte nello script "setup.m"
%Carica la struct di descrizione dei canali
channel = load(ChanlocsPath).Channel;
%Carica il vettore degli istanti di tempo
time = load(DataPath).Time;
%Carica il vettore dei flags
ch_flag = load(DataPath).ChannelFlag;
%Carica la matrice dei dati registrati
data.eeg = load(DataPath).F;
%Carica nel campo Trigger la traccia che contiene il tracciato del segnale
%di riferimento degli stimoli(nel caso specifico il canale denominato STIM)
data.Trigger = data.eeg(1,:);

