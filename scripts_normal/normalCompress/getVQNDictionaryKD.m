function dict = getVQNDictionary(nEps,maxSize)

    %the max inter-codeword distance for sphere(n) turns out to be described by
    %
    % 180 * \prod_{i=1}^n (i) / (i+1)

    qError = 180;
    for i=1:floor(sqrt(maxSize)-1);
        eltSqrt = i;
        if qError < nEps
            break;
        end
        qError = qError * (i)/(i+1);
    end

    [X,Y,Z] = sphere(eltSqrt);
    N = cat(3,X,Y,Z);
    V = reshape(N,[],3);

    dict.codebook = V;
    dict.levels = eltSqrt;
    dict.kd = vl_kdtreebuild(V');

end
