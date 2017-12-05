close all;
clear;
clc;

%% Pembagian Data
dataset = xlsread('Trainset.xls');
dtrain = dataset(:,1:10);
ktrain = dataset(:,11);
% preprocessing
dtrain = normalisasi(dtrain);
k = 10;
[dataval,datatrain, kelasval, kelastrain] = KFoldCrossValidation(dtrain, ktrain, k);

%% Learning ANN dengan GA
    % Parameter
    nGenerasi = 100;
    ukPop = 250;
    nGen = 154; %bobot1+bias1+bobot2+bias2 = 10*10 + 1*10 + 10*4 + 1*4
    pCrossover = 0.85;
    pMutasi = 0.0064;
    pSelection = 0.5;
    ukTurnamen = 8;
    nReplikasi = 2;
    
    for fold=1:k
        fprintf('k=%i\n',fold);
        % Variabel
        fitness = zeros(ukPop, 1);

        % Inisialiasai Populasi
        populasi = inisialisasiPopulasi(ukPop, nGen);
    
    
        % Loop tiap generasi
        for iGenerasi = 1: nGenerasi
%             fprintf('Generasi: %i of %i\n', iGenerasi, nGenerasi);
            % Cari nilai fitness yang terbaik
            fitness = cekFitnessPopulasi(populasi, cell2mat(datatrain(fold)), cell2mat(kelastrain(fold)));
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
        fitness = cekFitnessPopulasi(populasi, cell2mat(datatrain(fold)), cell2mat(kelastrain(fold)));
        [bestFitness, indeks] = max(fitness);
        bestKrom = populasi(indeks,:);
        akurasi = fitnessakurasi(bestKrom, cell2mat(dataval(fold)), cell2mat(kelasval(fold)));
        fprintf('Akurasi: %f\n',akurasi);
    end

%% Save Best Kromosom
save hasilTrainingJSTdenganGA bestKrom