function dict = getDepthDict(qError)
    maxDepth = 10;
    nEntries = (10.0 / qError)+1;
    dict.codebook = linspace(0,maxDepth,nEntries);            
end
