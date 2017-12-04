function [prediksi] = prediksi(bestKrom, datatesting)

    % variabel
    ndata = size(datatesting,1);
    jumBenar = 0;
    prediksi = zeros(size(datatesting,1), 1);

    
    bobot1 = reshape(bestKrom(1:40), [10,4]);
    bias1 = reshape(bestKrom(41:44), [1,4]);
    bobot2 = reshape(bestKrom(45:60), [4,4]);
    bias2 = reshape(bestKrom(61:64), [1,4]);

    for i=1:ndata
    %     forward
        v1 = datatesting(i,:)*bobot1+bias1;
    %         fungsi aktivasi tanh dari input ke hidden
        A1 = (2./(1+exp(-2*v1)))-1;
        v2 = A1*bobot2+bias2;
    %     fungsi aktivasi softmax dari hidden ke output
        maxv2 = max(v2,[],1);
        v2 = bsxfun(@minus, v2, maxv2);
        expv2 = exp(v2);
        sumexp = sum(expv2,1);
        sumexp(sumexp==0) = 1;
        A2 = expv2./sumexp;
        
%         A2 = exp(v2)./sum(exp(v2));

        prediksi(i) = decode(A2);
        
    end
end