function ret_lst = block_det(idx_lst)
%%Eliminazione degli indici consecutivi lasciando solo il primo
%Vettore ausiliario
vect=ones(1,size(idx_lst,2));
 for n = 2: length(vect)
     %Calcola la condizione da verificare (indici consecutivi)
     cond = idx_lst(n) - idx_lst(n-1);
        %Se verificata la condizione, azzera il corrispondente indice nel
        %vettore ausiliario
        if cond == 1
            vect(n) = 0;
        end
 end
 %Scandisce il vettore ausiliario per eliminare gli indici in successione;
 %la direzione "all'indietro" serve a non compromettere la corrispondenza
 %degli indici.
 for n = length(vect):-1:1
     %Eliminazione dei valori nella lista secondo il vettore ausiliario
     if vect(n) == 0
         idx_lst(n) = [];
     end
 end
 %Restituisce la lista indici semplificata
ret_lst = idx_lst;
end
