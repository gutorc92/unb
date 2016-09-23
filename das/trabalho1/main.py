import sys
from models import Input,Net,Face,Output,caffe_root
import cv2
import caffe
import numpy as np
import os

def main(argv=sys.argv):
	mu = np.load(os.path.join(caffe_root, 'python','caffe','imagenet','ilsvrc_2012_mean.npy'))
	mu = mu.mean(1).mean(1)  

	model_weights = os.path.join(caffe_root, 'models','bvlc_reference_caffenet','bvlc_reference_caffenet.caffemodel')
	model_def = os.path.join(caffe_root, 'models', 'bvlc_reference_caffenet','deploy.prototxt')
	net = caffe.Net(model_def,model_weights,caffe.TEST)

	transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape})
	transformer.set_transpose('data', (2,0,1))
	transformer.set_mean('data', mu)      
	transformer.set_raw_scale('data', 255)      
	transformer.set_channel_swap('data', (2,1,0)) 
		
	labels_file = os.path.join(caffe_root, 'data','ilsvrc12','synset_words.txt')
	labels = np.loadtxt(labels_file, str, delimiter='\t') 
	
	f = Face()
	n = Net(net,transformer,labels)
	o = Output()
	if(len(argv) >= 2):

		
		argv.pop(0)
		for arg in argv:
			print(arg)
			d = Input(arg)
			o.outFaces(f.detect(d.getImage(Input.FACES)))
			dogs,cats = n.result(d.getImage(Input.PREDICTION))
			o.outAnimals(dogs,cats)
			
if __name__=="__main__":
	main()
