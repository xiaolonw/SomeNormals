function clusterData = loadRankedClusters(clusterSplitPath, clusterUseFrac)
    %Load the ranked collection of clusters into memory 
    fprintf('Loading ranked clusters\n');

    %load the detectorIds
    fprintf(' Loading ids\n');
    load([clusterSplitPath '/detectors/detectors.mat'],'detectorIds');
    nDetectors = numel(detectorIds);

    %load the ranked list of clusters
    fprintf('Loading rank cache\n');
    clusterListFid = fopen([clusterSplitPath '/metadata/clusterRanks.txt']);
    clusterListData = textscan(clusterListFid, '%s');
    fclose(clusterListFid);

    clusterList = clusterListData{1};
    rankedIds = zeros(nDetectors,1);
    for i=1:numel(clusterList)
        rankedIds(i) = str2num(strrep(clusterList{i},'c_',''));
    end

    %collect the actual data

    %whether the cluster is considered active, and various information we need about it
    clusterData.active = zeros(nDetectors,1);
    clusterData.clusterDirectory = cell(nDetectors,1);
    clusterData.medianPatches = cell(nDetectors,1);
    clusterData.priors = cell(nDetectors, 1);
    clusterData.imageNames = cell(nDetectors, 1);
    clusterData.bboxes = cell(nDetectors, 1);
    clusterData.patchStats = cell(nDetectors, 1);


    fprintf('Loading cluster data\n');

    %load only the clusterUseFrac first clusters
    nToUse = fix(clusterUseFrac*nDetectors);
    for i=1:nToUse
        fprintf(' loading cluster %d/%d\n', i, nToUse);
        currentId = rankedIds(i);
        %where it is in the detector array
        location = find(detectorIds==currentId);
        %actually dump it into our data structure
        clusterData.active(location) = 1; 
        clusterData.clusterDirectory{location} = [clusterSplitPath '/clusters/c_' num2str(currentId) '/'];
        clusterLocation = clusterData.clusterDirectory{location};

        clusterData.medianPatches{location} = load([clusterLocation '/medianPatch.mat']);
        clusterData.priors{location} = loadPrior(clusterLocation);
        clusterData.patchStats{location} = load([clusterLocation '/patchStats.mat']);
       

        filenames = dir([clusterLocation '/filename*txt']);
        sourceFiles = {};
        for i=1:numel(filenames)
            fid = fopen([clusterLocation '/' filenames(i).name]);
            sourceFiles{i} = fscanf(fid,'%s');
            fclose(fid);
        end
        clusterData.imageNames{location} = sourceFiles;

        bboxes = {};
        for i=1:numel(filenames)
            bboxFilename = strrep(filenames(i).name,'filename','bbox');
            bboxes = [bboxes, dlmread([clusterLocation '/' bboxFilename])];
        end 
        clusterData.bboxes{location} = bboxes;
    end

    fprintf('Done!\n');


end
