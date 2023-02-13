function acceptpoint = boltzacceptancefun(optimValues, ~, newfval)

if newfval <= optimValues.fval
    acceptpoint = true;
elseif rand(1) <= exp((optimValues.fval - newfval)/max(optimValues.temperature))
        acceptpoint = true;
else
    acceptpoint = false;
end
end

