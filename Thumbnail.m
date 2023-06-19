function thum = Thumbnail(img,block)
    [M,N,C] = size(img);
    m = M/block;
    n = N/block;
    thum = imresize(img,[m n]);
    for c = 1 : C
    for i = 1 : m
        for j = 1 : n
            thum(i,j,c) = uint8(mean2(img(block*(i-1)+1:block*i,block*(j-1)+1:block*j,c)));
        end
    end
    end
end