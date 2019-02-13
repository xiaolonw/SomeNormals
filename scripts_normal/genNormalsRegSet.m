addpath(genpath('./'));
nDict = load('normalCompress/vq_dict.mat');
dDict = load('depthCompress/vq_dict.mat');
n2Src = '/nfs/hn46/dfouhey/deepProcessedImageDS/dataTVDenoise/train/train/';
imgsrc = '/nfs/hn46/dfouhey/deepProcessedImageDS/data/train/';

trainlist = '/nfs.yoda/xiaolonw/faster_rcnn/surface_normals/trainlist_whole.txt'; 
lblfolder = '/nfs.yoda/xiaolonw/faster_rcnn/surface_normals/labels/'; 
imgfolder = '/nfs.yoda/xiaolonw/faster_rcnn/surface_normals/imgs/';

normlist = dir([n2Src '/*_norm.mat']); 

sample_num = numel(normlist); 
matSize = 32; 

fid = fopen(trainlist, 'w'); 


for i = 1 : sample_num

    nname = normlist(i).name; 
    imname = strrep(nname,'norm.mat','rgb.jpg');

    vocab = load('vocab40.mat');
    nd2 = load([n2Src '/' nname]);
    N2 = nd2.N; 
    % [N2,NM2] = reconstructNormals(nd2.N,nDict.dict);
    reIm = imresize(N2, [matSize, matSize]);
    [idx, qloss] = assignToCodebook(reIm, vocab.vocabs{1}.normals);
    % idx=idx';
    idx=idx-1;%zero indexing

    norm_name = [lblfolder '/' nname]; 
    src_im_name = [imgsrc '/' imname];
    save_im_name = [imgfolder '/' imname]; 
    cmd = ['cp ' src_im_name ' ' save_im_name]; 
    system(cmd);

    save(norm_name, 'idx'); 

    fprintf(fid, 'imgs/%s labels/%s\n', imname, nname); 


end


fclose(fid);



