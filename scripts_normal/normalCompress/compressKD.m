run('vlfeat-0.9.18/toolbox/vl_setup.m');

dict = getVQNDictionaryKD(2,2^16-1);

fprintf('Verifying DP / ||-||_2 equivalence\n');

nRuns = 1000;
for sampleI=1:nRuns
    if mod(sampleI,100) == 0
        fprintf('%d / %d = %.2f\n',sampleI,nRuns,sampleI/nRuns*100);
    end
    q = rand(3,1); q = q ./ norm(q);

    i1 = vl_kdtreequery(dict.kd,dict.codebook',q);
    [~,i2] = max(dict.codebook*q);

    r1 = dict.codebook(i1,:); r2 = dict.codebook(i2,:);

    if norm(r1-r2) >1e-12
        keyboard;
    end
end

normalSource = '/nfs/ladoga_no_backups/users/dfouhey/NYUData/normals/';
%normalSource2 = '/nfs/ladoga_no_backups/users/dfouhey/depthPatches2/normals4/';

maxThetas = [];
times = [];
for i=1:1449
    load(sprintf('%s/nm_%06d.mat',normalSource,i));

    N = cat(3,nx,ny,nz); V = depthValid;
    fprintf('VQing %d/%d\n',i,1449);  
    tk = tic;
    QK = vqNormalsKD(N,dict,V);
    kt = toc(tk);

    tr = tic;
    QR = vqNormals(N,dict,V);
    rt = toc(tr);
    
    RK = reconstructNormals(QK,dict);

    RR = reconstructNormals(QK,dict);

    times(end+1,:) = [kt,rt];

    dp = acosd(min(1,max(-1,sum(RK.*RR,3))));
    theta = dp(find(V));
end
