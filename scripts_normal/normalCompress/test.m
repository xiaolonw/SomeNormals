addpath('utils/');
%load('vq_dict.mat');
normalSource = '/nfs/ladoga_no_backups/users/dfouhey/NYUData/normals/';
normalSource2 = '/nfs/ladoga_no_backups/users/dfouhey/depthPatches2/normals4/';

dict = getVQNDictionary(2,2^16-1);

i=10;
load(sprintf('%s/nm_%06d.mat',normalSource,i));

N = cat(3,nx,ny,nz); V = depthValid;
fprintf('VQing %d/%d\n',i,1449);  

vqbt = tic;
Q1 = vqNormals(N,dict,V);
toc(vqbt);

vqat = tic;
Q2 = vqAnalytic(N,dict,V);
toc(vqat);










