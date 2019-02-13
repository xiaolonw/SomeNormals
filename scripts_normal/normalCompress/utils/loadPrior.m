function locations = loadPrior(clusterSource)
    bboxFiles = dir([clusterSource '/bbox*txt']);
    
    locations = [];

    for i=1:numel(bboxFiles)
        patchNumber = str2num(strrep(strrep(bboxFiles(i).name, 'bbox_', ''),'.txt',''));
        bbox = dlmread(sprintf('%s/%s',clusterSource,bboxFiles(i).name)); 
        imageSize = dlmread(sprintf('%s/imagedim_%d.txt',clusterSource,patchNumber));
        cX = mean([bbox(1),bbox(3)]) / imageSize(2);
        cY = mean([bbox(2),bbox(4)]) / imageSize(1);
        locations = [locations; cX, cY];
    end 

end
