vect = zeros(1,length(TriggerList));
n_bl=1;
vect(1) = n_bl;
for n = 1:(length(TriggerList)-1)
    vect(n)= n_bl;
    if TriggerList(n+1) ~= (1+TriggerList(n))
        n_bl = n_bl + 1;
        vect(n+1) = n_bl;
    end
end
clear 'n_bl';
clear 'n';
