function Q = vqDepth(D,dict,M)
    if nargin < 3
        M = ones(size(D));
    end

    dictSize = size(dict.codebook,2);
    castF = @(x)(uint32(x));
    if dictSize < (2^8)-1
        castF = @(x)(uint8(x));
    elseif dictSize < (2^16)-1
        castF = @(x)(uint16(x));
    end
    Dv = D(:);
    inds = interp1(dict.codebook,1:numel(dict.codebook),Dv,'nearest','extrap');
    Q = castF(reshape(inds,size(D)) .* M);
end
