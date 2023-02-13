function [whiteMatrix, dewhiteMatrix] = pcaWhitening(eeg_c)
%funzione che calcola le matrici di sbiancamento 'whiteMatrix' e
%desbiancamento 'dewhiteMatrix' a partire dai dati in X, usando la PCA

%% Calcolo della matrice delle covarianze
    covarianceMatrix = cov(eeg_c', 1);
    
%% Calcolo degli autovalori e relativi autovettori della matrice delle covarianze
    [E, D] = eig(covarianceMatrix, 'vector');
    [D, I] = sort(D, 'descend');
    k = nnz(D > 1e-14);
    D = D(1:k);
    E = E(:,I(1:k));
    
%% Calcolo delle matrici di sbiancamento e desbiancamento
    whiteMatrix = (sqrt(D.^-1)).*E';
    dewhiteMatrix = E.*sqrt(D');
    
end
