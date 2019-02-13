function normPatch = normalizePatch(patch)
    normDiv = sum(patch.^2,3).^0.5;
    normPatch = patch ./ repmat(normDiv + eps, [1, 1, 3]); 
end
