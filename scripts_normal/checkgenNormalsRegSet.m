addpath(genpath('./'));
nDict = load('normalCompress/vq_dict.mat');
dDict = load('depthCompress/vq_dict.mat');
n2Src = '/nfs/hn46/dfouhey/deepProcessed/dataTVDenoise/';
src = '/nfs/hn46/dfouhey/deepProcessed/data/';
cvxccSrc = '/nfs/hn46/dfouhey/deepProcessed/cvxcc2/';
gravitySrc ='/nfs/hn46/dfouhey/deepProcessed/gravity/'; 
vpSrc = '/nfs/hn46/dfouhey/deepProcessed/vps/';

%this controls which source is loaded
srcNum = 160;
matSize = 55;

filesDir = dir(src);
sequences = {};
for i=1:numel(filesDir)
    name = filesDir(i).name;
    if name(1) ~= '.', sequences{end+1} = filesDir(i).name; end
end

for srcNum = 1 : 1

sequence = 'bedroom_0132';%sequences{srcNum};

sequenceDir = [src '/' sequence '/'];
tvSequenceDir = [n2Src '/' sequence '/' ];

fid = fopen(['temp/' sequence '_label.txt'], 'w'); 
%fid = fopen(['../labels_normalReg/' sequence '_label.txt'], 'w'); 

depths = dir([sequenceDir '/*depth.mat']);
for di=1:10
    fprintf('%d / %d\n',di,numel(depths));

    name = depths(di).name;
    imname = strrep(name,'depth.mat','rgb.jpg');
    nname = strrep(name,'depth.mat','norm.mat');
    bname = strrep(name,'depth.mat','boundary.png');
    vpname = strrep(name,'depth.mat','vp.mat');
    gname = strrep(name,'depth.mat','g.mat');

    %Load all the data
    a = load('vocab.mat');
    nd2 = load([tvSequenceDir '/' nname]); [N2,NM2] = reconstructNormals(nd2.N,nDict.dict);
    reIm = imresize(N2, [matSize, matSize]);
    
    oriReIm = reIm;

    x1 = reIm(:,:,1) .* reIm(:,:,1);
    y1 = reIm(:,:,2) .* reIm(:,:,2);
    z1 = reIm(:,:,3) .* reIm(:,:,3);
    s1 = x1 + y1 + z1;
    s1 = sqrt(s1) + 0.000001;
    reIm(:,:,1) = reIm(:,:,1) ./ s1;
    reIm(:,:,2) = reIm(:,:,2) ./ s1;
    reIm(:,:,3) = reIm(:,:,3) ./ s1;
	%keyboard;	
	fileName = [sequence '/'  imname ];
	fprintf(fid, '%s ', fileName);  
	for i = 1 : numel(reIm) 
		fprintf(fid, '%f ', reIm(i)); 
	end
	fprintf(fid, '\n');

end
fclose(fid); 

end
