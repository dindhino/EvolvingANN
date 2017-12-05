function population = inisialisasiPopulasi(ukPop, nGen)
    population = zeros(ukPop, nGen);
    for pop=1:ukPop
        beta1 = 0.7*(10^(1/10));
        bobot1 = rand(10, 10)*range([-0.5 0.5])+(-0.5);
        vj1 = sqrt(sum(bobot1.^2));
        bobot1 = (beta1*bobot1);
        for i=1:10
            bobot1(:,i) = bobot1(:,i)/vj1(i);
        end
        bias1 = rand(1, 10)*range([-beta1 beta1])+(-beta1);    
        beta2 = 0.7*(4^(1/10));
        bobot2 = rand(10, 4)*range([-0.5 0.5])+(-0.5);
        vj2 = sqrt(sum(bobot2.^2));
        bobot2 = (beta2*bobot2);
        for i=1:4
            bobot2(:,i) = bobot2(:,i)/vj2(i);
        end
        bias2 = rand(1, 4)*range([-beta2 beta2])+(-beta2);
        population(pop,:) = [reshape(bobot1, [1 100]) reshape(bias1, [1 10]) reshape(bobot2, [1 40]) reshape(bias2, [1 4])];
    end
return