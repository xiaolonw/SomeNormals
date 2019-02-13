
pairedSources = {'/nfs/ladoga_no_backups/users/dfouhey/NYUData/normals/','compa1/';
                 '/nfs/ladoga_no_backups/users/dfouhey/depthPatches2/normals4/','compa2/'};

load('vq_dict.mat');

distort = {};

for pair=1:size(pairedSources,1)
    orig = pairedSources{pair,1};
    new = pairedSources{pair,2};

    for i=1:1449

        fprintf('%d / %d\n',i,1449);

        origD = load(sprintf('%s/nm_%06d.mat',orig,i));
        try
            N = origD.normalMap; V = origD.valid;
        catch
            N = cat(3,origD.nx,origD.ny,origD.nz);
            V = origD.depthValid;
        end
        newD = load(sprintf('%s/nmcomp_%06d.mat',new,i));
        [rN, rV] = reconstructNormals(newD.Q,dict);
        fprintf('Diff: %d\n',sum(rV(:)~=V(:)));
        AM = acosd(min(1,max(-1,sum(N.*rN,3))));

        amv = AM(find(V));
        fprintf('Min angle: %f\n',min(amv));
        fprintf('Mean angle: %f\n',mean(amv));
        fprintf('Median angle: %f\n',median(amv));
        fprintf('Max angle: %f\n',max(amv));

        rp = randperm(numel(amv));
        distort{end+1} = amv(rp(1:500));
    end
end

D = cat(1,distort{:});
