function nilaiFitness = cekFitnessPopulasi(x, datatraining, klasifikasi)

    nilaiFitness = zeros(size(x,1),1);

    for index = 1:size(x,1)
        nilaiFitness(index) = fitnessakurasi(x(index,:), datatraining, klasifikasi);
    end
end