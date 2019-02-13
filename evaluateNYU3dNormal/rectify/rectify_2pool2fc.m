vpSrc = '/nfs/ladoga_no_backups/users/dfouhey/canonical/predictionPaper/';

fileSrc = '/nfs/hn46/xiaolonw/cnncode/caffe-3dnormal/3dnormal_result_small/3dnormal_210000_2pool/';
fileFormat = 'rgb_%06d.mat';

target = '/nfs/hn46/xiaolonw/cnncode/viewer/evaluateNYU3dNormal/rectified_2pool2fc/';

filename = @(i)(sprintf([fileSrc fileFormat],i));
loadfn = @(m)(decrop(resizeNormals(m.N3,[427,561])));


for i=1:1449
    fprintf('%d / %d\n',i,1449);
    if ~exist(filename(i)), continue; end

    outputFile = sprintf([target fileFormat],i);

    if exist(outputFile) || isLocked([outputFile '.lock'])
        continue;
    end

    try
        vpData = load(sprintf('%s/rgb_%06d.jpg.nmap.mat',vpSrc,i)); 
    catch
        continue;
    end 
    N = loadfn(load(filename(i)));
    vpraw = vpData.nd.vp;
    vppack = {vpraw(1:2), vpraw(3:4), vpraw(5:6)};
    NOpts = computeNormalEstimates(vppack, vpData.nd.f, size(N,2), size(N,1));
    NOpts = [NOpts; -NOpts];
    Nv = reshape(N,[],3);
    [~,idx] = max(Nv*NOpts',[],2);
    Nvr = Nv;
    for c=1:3, 
        NOptsc = NOpts(:,c);
        Nvr(:,c) = NOptsc(idx);
    end
    normalMap = reshape(Nvr,size(N));
    save(outputFile,'normalMap');

    unlock([outputFile '.lock']);
end
