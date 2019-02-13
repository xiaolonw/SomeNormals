function vis = visualizeRawNormal(normalMap, valid)
    vis = zeros(size(normalMap,1),size(normalMap,2),3,'uint8');
    for c=1:3
        cvis = uint8(((normalMap(:,:,c)+1)/2) .* 255);
        cvis(~valid) = 0;
        vis(:,:,c) = cvis;
    end
end
