function nilaiFitness = fitnessakurasi(x, datatraining, klasifikasi)
    % variabel
    ndata = size(datatraining,1);
    jumBenar = 0;
    
    bobot1 = reshape(x(1:100), [10,10]);
    bias1 = reshape(x(101:110), [1,10]);
    bobot2 = reshape(x(111:150), [10,4]);
    bias2 = reshape(x(151:154), [1,4]);
    
%     totalerror = [];
    for i=1:ndata
    %     forward
        v1 = datatraining(i,:)*bobot1+bias1;
    %         fungsi aktivasi tanh dari input ke hidden
        A1 = (2./(1+exp(-2*v1)))-1;
        v2 = A1*bobot2+bias2;
    %     fungsi aktivasi softmax dari hidden ke output
        A2 = exp(v2)/sum(exp(v2));
        
        [nilai indeks] = max(A2);
        if indeks == klasifikasi(i)
            jumBenar = jumBenar + 1;
        end
        
    end
    
    nilaiFitness = 100*jumBenar/ndata;
end
