function terpilih = seleksiTurnamen(nilaiFitness, pSelection, ukTurnamen)

    ukPop = size(nilaiFitness,1) ;

    %pilih kandidat sebanyak tournamentSize untuk tournament
    kandidat = 1 + fix(rand(1,ukTurnamen)*ukPop);
    nilaiFitnessKandidat = nilaiFitness(kandidat);
    [~, indeks] = sort(nilaiFitnessKandidat,1,'descend');
    matprobSeleksi = pSelection*((1-pSelection).^(0:ukTurnamen-2)');
    r = rand;
    terpilih = kandidat(indeks(r>matprobSeleksi));
    if isempty(terpilih)
        terpilih = kandidat(indeks(end));
    else
        terpilih = terpilih(1);
    end
end