function population = inisialisasiPopulasi(ukPop, nGen)
    desimal = 3;
    population = randi([-25, 25]*10^desimal,[ukPop, nGen])/10^desimal;
return