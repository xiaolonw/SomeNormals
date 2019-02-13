function flatDetections = flattenDetections(detectionData)
    numDetections = detectionData.detections.firstLevel.numDetections;
    %get to the actual detection structure, which is 1 x NumDetectors
    detectionStruct = detectionData.detections.firstLevel.detections;
  
    %each row: [model id, score, minX, minY, maxX, maxY]
    flatDetections = zeros(numDetections,6);
    nextEntry = 1;
    for modelId=1:numel(detectionStruct)
        modelDetections = detectionStruct(modelId);
        for detectId=1:numel(detectionStruct(modelId).metadata)
            detect = modelDetections.metadata(detectId);
            flatDetections(nextEntry,:) = [ modelId, 
                                            modelDetections.decision(detectId),
                                            min(detect.x1,detect.x2),
                                            min(detect.y1,detect.y2),
                                            max(detect.x1,detect.x2),
                                            max(detect.y1,detect.y2)];
            
            nextEntry = nextEntry + 1;
        end 
    end

end
