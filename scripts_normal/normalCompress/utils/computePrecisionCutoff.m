function scoreCutoff = computePrecisionCutoff(scoreAndPrecision, cutoff)
    %takes a Nx2 matrix of [scores, cumulative precisions] and finds the 
    %lowest score such that the cumulative precision is at least cutoff
    if max(scoreAndPrecision(:,2)) < cutoff
        scoreCutoff = 1e10;
        return;
    end
    maxIndex = max(find(scoreAndPrecision(:,2) >= cutoff));
    scoreCutoff = scoreAndPrecision(maxIndex,1); 
end
