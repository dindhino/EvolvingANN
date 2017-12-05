function [prediksi] = prediksi(bestKrom, datatesting)

    % variabel
    ndata = size(datatesting,1);
    jumBenar = 0;
    prediksi = zeros(size(datatesting,1), 1);

    
    bobot1 = reshape(bestKrom(1:100), [10,10]);
    bias1 = reshape(bestKrom(101:110), [1,10]);
    bobot2 = reshape(bestKrom(111:150), [10,4]);
    bias2 = reshape(bestKrom(151:154), [1,4]);

    for i=1:ndata
    %     forward
        v1 = datatesting(i,:)*bobot1+bias1;
    %         fungsi aktivasi tanh dari input ke hidden
        A1 = (2./(1+exp(-2*v1)))-1;
        v2 = A1*bobot2+bias2;
    %     fungsi aktivasi softmax dari hidden ke output
        A2 = exp(v2)/sum(exp(v2));
        
%         A2 = exp(v2)./sum(exp(v2));

        prediksi(i) = decode(A2);
        
    end
end