function drawImage = drawBBox(image, bbox, color, thickness)
    minX = bbox(1); minY = bbox(2); maxX = bbox(3); maxY = bbox(4);
    h = size(image,1); w = size(image,2);
    drawImage = image;
    for c=1:3
        chan = image(:,:,c);
        rows = clip([minY-thickness:minY+thickness,maxY-thickness:maxY+thickness],1,h);
        cols = clip([minX-thickness:minX+thickness,maxX-thickness:maxX+thickness],1,w);
        chan(rows,clip(minX:maxX,1,w)) = color(c);
        chan(clip(minY:maxY,1,h),cols) = color(c);
        drawImage(:,:,c) = chan;
    end
end

function cx = clip(x, minVal, maxVal)
    cx = min(max(x,minVal),maxVal); 
end

