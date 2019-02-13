import sys
sys.path.insert(0,'../../caffe-unsup-joint/python');
import caffe
import surgery, score

import numpy as np
import os
import sys


from PIL import Image
import scipy.io

from numpy import linalg as LA



caffe.set_device(0)
caffe.set_mode_gpu()

net = caffe.Net('test.prototxt',
                '/nfs.yoda/xiaolonw/faster_rcnn/video_models/nyud-3dnormals_unsup_xavier/train_iter_200000.caffemodel',
                caffe.TEST)

outpath = '/nfs.yoda/xiaolonw/faster_rcnn/3dnormal_results/nyud-3dnormals_unsup_xavier/200k/'
testlist = '/scratch/xiaolonw/surface_normals/testlist.txt' 

vocabfile = '/nfs.yoda/xiaolonw/faster_rcnn/fcn_unsup/scripts_normal/vocab40.mat'
vocab = scipy.io.loadmat(vocabfile)
now_dict = vocab['vocabs'][0][0]['normals'][0][0]

label_size = 32
class_size = 40

indices = open(testlist, 'r').read().splitlines()


for i in range(654):
	out = net.forward()
	prop = out['softmax']

	imname = outpath + indices[i] + '.jpg'
	matname = outpath + indices[i] + '.mat'
	print(i)

	out_im = np.zeros((label_size, label_size, 3)) 

	for j in range(label_size):
		for k in range(label_size):
			vec = prop[0, :, j, k]
			vec = np.reshape(vec, (1, class_size) ) 
			norm_feat = np.dot(vec, now_dict)
			l2norm = (LA.norm(norm_feat) + 1e-8)
			norm_feat = norm_feat / l2norm

			out_im[j][k][:] = norm_feat[:]


	imnorm = np.copy(out_im)
	imnorm = imnorm * 128 + 128
	imnorm = imnorm.astype(np.uint8) 

	result = Image.fromarray(imnorm)
	result.save(imname)

	scipy.io.savemat(matname, {'N3':out_im} )














