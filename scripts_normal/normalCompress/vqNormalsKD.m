function Q = vqAnalytic(N,dict,M)
    if nargin < 3
        M = ones(size(N,1),size(N,2));
    end

    nLevels = dict.levels;

    %figure out the output
    dictSize = size(dict.codebook,1);
    castF = @(x)(uint32(x));

    if dictSize < (2^8)-1
        castF = @(x)(uint8(x));
    elseif dictSize < (2^16)-1
        castF = @(x)(uint16(x));
    end

    Nv = reshape(N,[],3);

    inds = double(vl_kdtreequery(dict.kd,dict.codebook',Nv'));

    Q = castF(reshape(inds,[size(N,1),size(N,2)]) .* M);
end


