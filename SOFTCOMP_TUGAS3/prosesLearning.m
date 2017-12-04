close all;
clear;
clc;

%% Pembagian Data
dataset = xlsread('Trainset.xls');
dtrain = dataset(1:6000,1:10);
ktrain = dataset(1:6000,11);
dval = dataset(6001:8000,1:10);
kval = dataset(6001:8000,11);

%% Learning ANN dengan GA
    % Parameter
    nGenerasi = 150;
    ukPop = 250;
    nGen = 64; %bobot1+bias1+bobot2+bias2 = 10*4 + 1*4 + 4*4 + 1*4
    pCrossover = 0.8;
    pMutasi = 0.04;
    pSelection = 0.5;
    ukTurnamen = 10;
    nReplikasi = 2;

    % Variabel
    fitness = zeros(ukPop, 1);

    % Inisialiasai Populasi
    populasi = inisialisasiPopulasi(ukPop, nGen);
    
    % Loop tiap generasi
    for iGenerasi = 1: nGenerasi
        fprintf('Generasi: %i of %i\n', iGenerasi, nGenerasi);
        % Cari nilai fitness yang terbaik
        fitness = cekFitnessPopulasi(populasi, dtrain, ktrain);
        [bestFitness, indeks] = max(fitness);
        bestKrom = populasi(indeks,:);

        % Backup Populasi
        newPopulasi = populasi;

        % Pembuatan generasi baru
        for i = 1:ukTurnamen:ukPop
            % Seleksi orang tua dengan seleksi turnamen
            iParent1 = seleksiTurnamen(fitness,pSelection,ukTurnamen);
            iParent2 = seleksiTurnamen(fitness,pSelection,ukTurnamen);
            parent1 = populasi(iParent1,:);
            parent2 = populasi(iParent2,:);

            % Crossover dengan satu titik potong
            r = rand;
            if ( r < pCrossover)
                child = crossover(parent1, parent2);
                newPopulasi(i,:) = child(1,:);
                newPopulasi(i+1,:) = child(2,:);
            else
                newPopulasi(i,:) = parent1;
                newPopulasi(i+1,:) = parent2;
            end
        end

        % Mutasi
        newPopulasi = mutasi(newPopulasi, pMutasi);

        % Elitisme
        bestKrom2 = populasi(indeks,:);
        newPopulasi = insertBestKrom2(newPopulasi, bestKrom2, nReplikasi);

        % Copy populasi baru
        populasi = newPopulasi;

    end
    
    fitness = cekFitnessPopulasi(populasi, dtrain, ktrain);
    [bestFitness, indeks] = max(fitness);
    bestKrom = populasi(indeks,:);
    fprintf('Best Fitness: %d\n',bestFitness);
    
    akurasilearning = fitnessakurasi(bestKrom, dtrain, ktrain)
    akurasivalidasi = fitnessakurasi(bestKrom, dval, kval)

%% Save Best Kromosom
save hasilTrainingJSTdenganGA bestKrom