function [N2] = assignToNormals(N, codebook)
    channelNum = size(codebook, 1);
    Nv = reshape(N, channelNum, []);
    Nv = Nv';
    N2 = Nv * codebook; 
end


