
import numpy as np
from PIL import Image
import scipy.io

split_f = '/nfs.yoda/xiaolonw/faster_rcnn/surface_normals/trainlist.txt'
src = '/scratch/xiaolonw/surface_normals/labels/'
outdir = '/nfs.yoda/xiaolonw/3dnormal/'
vocabfile = 'vocab40.mat'

indices = open(split_f, 'r').read().splitlines()

label_size = 32

vocab = scipy.io.loadmat(vocabfile)
now_dict = vocab['vocabs'][0][0]['normals'][0][0]

for i in range(len(indices)):

	imnorm = np.zeros((label_size, label_size, 3)) 
	fname  = indices[i]
	imname = outdir + fname + '_rgb_encode.jpg'

	fname = src + fname + '_norm.mat'
	label = scipy.io.loadmat(fname)['idx'].astype(np.uint8)

	for j in range(label_size):
		for k in range(label_size):

			nowlabel = label[j][k]
			imnorm[j][k][:] = now_dict[nowlabel][:]

	imnorm = imnorm * 128 + 128
	imnorm = imnorm.astype(np.uint8) 

	result = Image.fromarray(imnorm)
	result.save(imname)








