function [idx,qloss] = assignToCodebook(N,codebook)
    h = size(N,1); w = size(N,2);
    Nv = reshape(N,[],3);
    [qlossv,idxv] = max(Nv*codebook',[],2);
    idx = reshape(idxv,[h,w]);
    qloss = reshape(qlossv,[h,w]);
    qloss = acosd(min(1,max(-1,qloss)));
end
