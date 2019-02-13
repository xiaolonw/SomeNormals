function imageColor = iimagesc(im,bounds)
    if nargin < 2
        bounds = [min(im(:)), max(im(:))];
    end
    imBound = uint8(255 .* (im - bounds(1)) ./ (bounds(2) - bounds(1)));
    imageColor = ind2rgb(gray2ind(imBound,255),jet(255)); 
end
