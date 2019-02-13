function vis = visualizeNormalImage(normalPacked)
    normals = (normalPacked + 1) / 2;
    vis = uint8(normals .* 255); 
end
