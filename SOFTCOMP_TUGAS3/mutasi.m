function tPop = mutasi(tPop, pMutasi)
    
    for iPop=1:size(tPop,1)
        if rand<pMutasi
            iTuker = randi([1 size(tPop,2)], [1 2]); %random 2 angka sesuai banyaknya gen
            
            if iTuker(1) ~= iTuker(2)
                %tuker tPop baris ke iPop kolom iTuker(1) sama kolom iTuker(2)
                tPop(iPop, iTuker(1)) = tPop(iPop, iTuker(1)) + tPop(iPop, iTuker(2));
                tPop(iPop, iTuker(2)) = tPop(iPop, iTuker(1)) - tPop(iPop, iTuker(2));
                tPop(iPop, iTuker(1)) = tPop(iPop, iTuker(1)) - tPop(iPop, iTuker(2));
            end
        end
    end

end

