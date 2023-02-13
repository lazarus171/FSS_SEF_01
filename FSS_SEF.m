function [AFS, WFS, FS, Retroprojected_FS, w] = FSS_SEF(eeg, triglist, maxSEF, lowSEF, highSEF, durata, pretrigger, bas, smpfq, lambda, T0)
% Funzione che esegue l'algoritmo FSS a partire da un eeg rilevato in
% presenza di un trigger

%% Centramento dell'EEG
    medie_eeg = mean(eeg, 2);
    eeg_c = eeg - medie_eeg;
    
    
%% Calcolo delle matrici di sbiancamento e desbiancamento a partire dall'EEG centrato
    [whiteMatrix, dewhiteMatrix] = pcaWhitening(eeg_c);
    
    
%% Sbiancamento dell'EEG centrato
    whiteEEGc = whiteMatrix * eeg_c;
    
    
%% Inizializzazione del punto iniziale per il Simulated Annealing
    w0 = whiteMatrix * (rand(size(eeg_c, 1), 1) - 0.5);
    
    
%% Definizione della funzione obiettivo
    fun_obj = @(w) -f_obj(w, whiteEEGc, triglist, maxSEF, lowSEF, highSEF, durata, pretrigger, bas, lambda, smpfq);
    
    
%% Settaggio del Simulated Annealing
    options = optimoptions(@simulannealbnd,...
        'AcceptanceFcn', @(optimValues, newx, newfval) boltzacceptancefun(optimValues, newx, newfval),...
        'AnnealingFcn','annealingboltz',...
        'DataType', 'double',...
        'FunctionTolerance', 1e-4,...
        'InitialTemperature', T0,...
        'ObjectiveLimit', -inf,...
        'TemperatureFcn', @(optimValues, options) options.InitialTemperature.*0.9.^(optimValues.k),...
        'HybridFcn', [],...
        'PlotFcn', {'saplotf', 'saplotx'},...
        'Display', 'iter',...
        'MaxIterations', 6000,...
        'MaxStallIterations', 1000,...
        'ReannealInterval', 50);
    lower_bound = -ones(size(w0));
    lower_bound(1) = 0; %Rimozione dell'ambiguità del segno sui pesi w
    upper_bound = ones(size(w0));
    
%%Massimizzazione della funzione obiettivo tramite Simulated Annealing
    rng default;
    [w, fval] = simulannealbnd(fun_obj, w0, lower_bound, upper_bound, options);
    w = w/norm(w);
    
%% Calcolo di  AFS e WFS
    AFS = dewhiteMatrix * w;
    WFS = w' * whiteMatrix;
    
    
%% Calcolo della sorgente funzionale FS e della sua retroproiezione sui canali Retroprojected_FS
    FS = w' * (whiteEEGc + whiteMatrix * medie_eeg);
    Retroprojected_FS = AFS * FS;
    
end