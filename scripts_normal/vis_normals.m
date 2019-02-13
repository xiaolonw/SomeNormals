


addpath(genpath('./'));
nDict = load('normalCompress/vq_dict.mat');
dDict = load('depthCompress/vq_dict.mat');

lblfolder = '/nfs.yoda/xiaolonw/faster_rcnn/surface_normals/labels/'; 

vocab = load('vocab40.mat');

lblfiles = dir([lblfolder '/*.mat']); 

sample_num = numel(lblfiles); 


for i = 1 : sample_num

	fname = lblfiles(i).name; 
	fname = [lblfolder '/' fname]; 


end






