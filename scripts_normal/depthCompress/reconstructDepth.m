function [D,M] = reconstructDepth(QD,dict)
    ind = QD(:);
    %make the unknown / invalid normals have some
    %index so we can do quick vectorized lookup
    ind(find(ind==0)) = 1;
    Dv = dict.codebook(ind);
    D = reshape(Dv,size(QD));
    M = (QD > 0);
    D = bsxfun(@times,D,double(M));
end
