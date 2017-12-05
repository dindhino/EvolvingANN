function newPopulasi = insertBestKrom2(populasi, bestKrom, nc)

    % Replace random
    newPopulasi = populasi;
    randomIndeks = ceil(rand(nc,1).*size(populasi,1));
    newPopulasi(randomIndeks,:) = repmat(bestKrom,nc,1);

end