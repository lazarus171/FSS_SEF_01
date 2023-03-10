function [whiteMatrix, dewhiteMatrix] = pcaWhitening(eeg_c)
%% Funzione che calcola le matrici di sbiancamento e desbiancamento a partire dai dati in X, usando la PCA

%% Calcolo della matrice delle covarianze
    covarianceMatrix = cov(eeg_c', 1);
    
%% Calcolo degli autovalori e relativi autovettori della matrice delle covarianze
    [E, D] = eig(covarianceMatrix, 'vector');
    [D, I] = sort(D, 'descend');
    %Riga del codice originale
    %k = nnz(D > 1e-14);
    %Riga modificata
    k = nnz(D > 1e-25);
    D = D(1:k);
    E = E(:,I(1:k));
    
%% Calcolo delle matrici di sbiancamento e desbiancamento
    whiteMatrix = (sqrt(D.^-1)).*E';
    dewhiteMatrix = E.*sqrt(D');
    
end
