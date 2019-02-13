function [N,M] = reconstructNormals(QN,dict)
    ind = QN(:);
    %make the unknown / invalid normals have some
    %index so we can do quick vectorized lookup
    ind(find(ind==0)) = 1;
    Nv = dict.codebook(ind,:);
    N = reshape(Nv,[size(QN,1),size(QN,2),3]);
    M = (QN > 0);
    N = bsxfun(@times,N,double(M));
end
