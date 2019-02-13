function Q = vqNormals(N,dict,M)
    if nargin < 3
        M = ones(size(N,1),size(N,2));
    end

    %vectorized normals (Nx3)
    Nv = reshape(N,[],3);

    [D,I] = pdist2(dict.codebook,Nv,'cosine','Smallest',1);

    dictSize = size(dict.codebook,1);
    castF = @(x)(uint32(x));

    if dictSize < (2^8)-1
        castF = @(x)(uint8(x));
    elseif dictSize < (2^16)-1
        castF = @(x)(uint16(x));
    end

    Is = [size(N,1),size(N,2)];

    Q = castF(reshape(I,Is).*M);
end
