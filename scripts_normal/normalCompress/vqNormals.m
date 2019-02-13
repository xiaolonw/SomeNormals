function Q = vqAnalytic(N,dict,M)
    if nargin < 3
        M = ones(size(N,1),size(N,2));
    end

    %how many isocontours to check. In practice, 1 is probably enough: if the 
    %closest point is in the second closest z-band, then the angular difference
    %will be < 0.01 degrees or so (for ~92 levels)
    zRet = 1;

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

    [dXp,dYp,dZp] = sphere(nLevels);

    isoPoints = {};
    for i=1:nLevels+1
        isoPoints{i} = [dXp(i,:)', dYp(i,:)', dZp(i,:)'];
    end


    nPoints = size(Nv,1);

    dZ = dZp(:,3);
    NvZ = Nv(:,3); 

    %figure out the z-isocontour it's on

    %probably can't beat pdist2 here...
    [isoD,isoInd] = pdist2(dZ,NvZ,'euclidean','Smallest',zRet);
    isoInd = isoInd';

    metaD = zeros(size(isoInd));
    metaI = zeros(size(isoInd));

    %search only along the correct z-isocontour
    for zi=1:zRet
        for i=1:nLevels+1
            toProcess = find(isoInd(:,zi)==i);
            if numel(toProcess)
                %can beat pdist2 here.
                [ip,bi] = max(Nv(toProcess,:)*isoPoints{i}',[],2);
                metaD(toProcess,zi) = ip; 
                metaI(toProcess,zi) = bi; 
            end
        end
    end


    [~,metaInd] = max(metaD,[],2);
    row = zeros(nPoints,1);
    col = zeros(nPoints,1);
    
    for i=1:zRet
        filter = (metaInd==i);
        row = row + filter .* isoInd(:,i);
        col = col + filter .* metaI(:,i);
    end

    inds = sub2ind(size(dXp),row,col);

    Q = castF(reshape(inds,[size(N,1),size(N,2)]) .* M);
end


