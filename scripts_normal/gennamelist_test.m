addpath(genpath('./'));
nDict = load('normalCompress/vq_dict.mat');
dDict = load('depthCompress/vq_dict.mat');
imgsrc = '/nfs/hn46/dfouhey/deepProcessedImageDS/data/test/';
trainlist = '/nfs.yoda/xiaolonw/faster_rcnn/surface_normals/testlist.txt'; 

normlist = dir([imgsrc '/*_rgb.jpg']); 

sample_num = numel(normlist); 

fid = fopen(trainlist, 'w'); 



for i = 1 : sample_num
	normname = normlist(i).name; 
	normname = normname(1:8);
	fprintf(fid, '%s\n', normname); 

end


fclose(fid);