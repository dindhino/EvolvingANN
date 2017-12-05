function child = crossover(parent1, parent2)

    nGen = size(parent1,2) ; 
    titikPotong = 1 + fix(rand*(nGen-1));
    assert(titikPotong>0 && titikPotong<=nGen);
    child(1, :) = [parent1(1:titikPotong) parent2(titikPotong+1:end)];
    child(2, :) = [parent2(1:titikPotong) parent1(titikPotong+1:end)];

end