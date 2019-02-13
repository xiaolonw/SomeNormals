function normals = computeNormalEstimates(vps, f, w, h)
    normals = [];
    cx = w / 2; cy = h / 2;
    for i=1:3
        otherIds = setdiff(1:3,[i]);
        vp1 = vps{otherIds(1)}; vp2 = vps{otherIds(2)};
        x1 = vp1(1); y1 = vp1(2); x2 = vp2(1); y2 = vp2(2);
        x1 = x1 - cx; x2 = x2 - cx;
        y1 = y1 - cy; y2 = y2 - cy;
        
        p = f*(y1 - y2)/(x1*y2 - x2*y1);
        q = f*(x2 - x1)/(x1*y2 - x2*y1);
        normals = [normals; p, q, 1];
    end
    normDiv = sum(normals.^2,2).^0.5;
    normals = normals ./ repmat(normDiv,1,3);
    
    unestimated = find(sum(isnan(normals),2));
    fprintf('%d overflows\n', numel(unestimated)); 
    if numel(unestimated) == 1
        estimated = setdiff(1:3,[unestimated]);
        normals(unestimated,:) = cross(normals(estimated(1),:),normals(estimated(2),:));
    elseif numel(unestimated) == 2
        estimated = setdiff(1:3,[unestimated]);
        normals(unestimated,:) = null(normals(estimated(1),:))';
    elseif numel(unestimated) == 3
        normals = eye(3); 
    end
end
