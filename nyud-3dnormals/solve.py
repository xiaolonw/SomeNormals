import sys
sys.path.insert(0,'../../caffe-unsup-joint/python');
import caffe
import surgery, score

import numpy as np
import os
import sys

try:
    import setproctitle
    setproctitle.setproctitle(os.path.basename(os.getcwd()))
except:
    pass

weights = '/nfs.yoda/xiaolonw/faster_rcnn/video_models/models_vgg_joint3/continue_m/model_iter_30000.caffemodel'


# init
caffe.set_device(int(sys.argv[1]))
caffe.set_mode_gpu()

solver = caffe.SGDSolver('solver.prototxt')
solver.net.copy_from(weights)

# surgeries
interp_layers = [k for k in solver.net.params.keys() if 'up' in k]
surgery.interp(solver.net, interp_layers)

for _ in range(100):
    solver.step(2000)


