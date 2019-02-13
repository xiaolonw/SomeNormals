addpath('./normalCompress')
splitNames = {'train'}
dirPath = '/nfs/hn46/dfouhey/deepProcessedImageDS/dataTVDenoise/train'

vocab = load('vocab20.mat');
nDict = load('normalCompress/vq_dict.mat');
imDims = [480, 640]

splitData = load('../../data/nyu2/splits.mat')
load('../../data/nyu2/nyu_depth_v2_labeled.mat','rawRgbFilenames')

for split=1
	splitPath = fullfile(dirPath, splitNames{split})
	flist = dir(splitPath);
	flist = {flist([flist.isdir]==0).name};
	if strcmp(splitNames{split},'train')
		tInds = splitData.trainNdxs;
	elseif strcmp(splitNames{split}, 'test')
		tInds = splitData.testNdxs;
	end
	fh = fopen(sprintf('../../data/nyu2/%sParList.txt', splitNames{split}),'w');
	for fInd=1:length(tInds)
		[subdir,bname,ext] = fileparts(rawRgbFilenames{tInds(fInd)});
		actName = sprintf('%05.jpg', tInds(fInd));
		actName = fullfile(subdir, actName);
		fprintf(fh,'%s %s\n', rawRgbFilenames{tInds(fInd)}, actName);
	end
	fclose(fh);

	labelGenFile = sprintf('../../genData/nyu2/sn20_nyu2-%s.h5', splitNames{split})
	delete(labelGenFile)
	for fInd=1:length(flist)
		srcName = rawRgbFilenames{tInds(fInd)};
		[subdir,bname,ext] = fileparts(srcName);
		actName = sprintf('%05d', tInds(fInd));
		actName = fullfile(subdir, actName);
		%imKey = fullfile(subdir, bname);
		imKey = sprintf('/%s',actName);
		actName = sprintf('%s.jpg',actName);

		fname = fullfile(splitPath, flist{fInd});
		nd2 = load(fname);
		outLabelFileName = '';
		%[N2,NM2] = reconstructNormals(nd2.N,nDict.dict)
		%for the image part of NYU, the actual (not VQ) normals are stored
		N2 = nd2.N;
		reIm = imresize(N2, imDims);
	    [idx, qloss] = assignToCodebook(reIm, vocab.vocabs{1}.normals);
	    %keyboard
	    %reshape for caffe, since matlab is col major
	    idx=idx';
	    idx=idx-1;%zero indexing
	    %idx = reshape(idx, [1,1,size(idx,1), size(idx,2)]);
	    %if fInd==1
	    h5create(labelGenFile, imKey, [size(idx,1), size(idx,2), 1, 1]);
    	h5write(labelGenFile, imKey, idx);
	    %else
	    %	h5write(labelGenFile, imKey, idx, 'WriteMode', 'append');
	    %end
	end
end