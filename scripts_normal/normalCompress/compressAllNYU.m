addpath('utils/');
run('vlfeat-0.9.18/toolbox/vl_setup.m');

dict = getVQNDictionaryKD(2,2^16-1);

save('vq_dict.mat','dict');
normalSource = '/nfs/ladoga_no_backups/users/dfouhey/NYUData/normals/';
normalSource2 = '/nfs/ladoga_no_backups/users/dfouhey/depthPatches2/normals4/';

if ~exist('compa1_4'), mkdir('compa1_4'); end
if ~exist('compa2_4'), mkdir('compa2_4'); end

for i=1:1449
    target = sprintf('compa1_4/nmcomp_%06d.mat',i);

    if exist(target) || isLocked([target '.lock'])
        continue;
    end
    load(sprintf('%s/nm_%06d.mat',normalSource,i));

    N = cat(3,nx,ny,nz); V = depthValid;
    fprintf('VQing %d/%d\n',i,1449);  
    Q = vqNormalsKD(N,dict,V);
%    Q = vqAnalytic(N,dict,V);
    save(target,'Q');
    unlock([target '.lock']);
end




for i=1:1449
    target = sprintf('compa2_4/nmcomp_%06d.mat',i);
    if exist(target) || isLocked([target '.lock'])
        continue;
    end

    load(sprintf('%s/nm_%06d.mat',normalSource2,i));
    N = normalMap; V = valid;
    fprintf('VQing %d/%d\n',i,1449);  
    Q = vqNormalsKD(N,dict,V);
%    Q = vqAnalytic(N,dict,V);
    save(target,'Q');
    unlock([target '.lock']);
end

