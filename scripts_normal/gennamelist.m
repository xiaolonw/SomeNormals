addpath(genpath('./'));
nDict = load('normalCompress/vq_dict.mat');
dDict = load('depthCompress/vq_dict.mat');
n2Src = '/nfs/hn46/dfouhey/deepProcessedImageDS/dataTVDenoise/train/train/';
imgsrc = '/nfs/hn46/dfouhey/deepProcessedImageDS/data/train/';

trainlist = '/nfs.yoda/xiaolonw/faster_rcnn/surface_normals/trainlist.txt'; 
lblfolder = '/nfs.yoda/xiaolonw/faster_rcnn/surface_normals/labels/'; 
imgfolder = '/nfs.yoda/xiaolonw/faster_rcnn/surface_normals/imgs/';



normlist = dir([n2Src '/*_norm.mat']); 

sample_num = numel(normlist); 
matSize = 32; 

fid = fopen(trainlist, 'w'); 



for i = 1 : sample_num
	normname = normlist(i).name; 
	normname = normname(1:8);
	fprintf(fid, '%s\n', normname); 

end


fclose(fid);