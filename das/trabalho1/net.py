import numpy as np
import caffe
import os
import sys

caffe_root = "/home/gustavo/caffe"

class Net:

	def __init__(self):
		model_weights = os.path.join(caffe_root, 'models','bvlc_reference_caffenet','bvlc_reference_caffenet.caffemodel')
		model_def = os.path.join(caffe_root, 'models', 'bvlc_reference_caffenet','deploy.prototxt')
		self.net = caffe.Net(model_def,model_weights,caffe.TEST)
		mu = np.load(os.path.join(caffe_root, 'python','caffe','imagenet','ilsvrc_2012_mean.npy'))
		mu = mu.mean(1).mean(1)  
		self.transformer = caffe.io.Transformer({'data': self.net.blobs['data'].data.shape})
		self.transformer.set_transpose('data', (2,0,1))
		self.transformer.set_mean('data', mu)      
		self.transformer.set_raw_scale('data', 255)      
		self.transformer.set_channel_swap('data', (2,1,0)) 
		self.create_labels()

	def create_labels(self):
		labels_file = os.path.join(caffe_root, 'data','ilsvrc12','synset_words.txt')
		self.labels = np.loadtxt(labels_file, str, delimiter='\t') 

	def predict_imageNet(self,image_filename):
		image = caffe.io.load_image(image_filename)
		self.net.blobs['data'].data[...] = self.transformer.preprocess('data', image)

		# perform classification
		self.net.forward()

		# obtain the output probabilities
		output_prob = self.net.blobs['prob'].data[0]

		# sort top five predictions from softmax output
		top_inds = output_prob.argsort()[::-1][:5]


		predictions = zip(output_prob[top_inds], self.labels[top_inds])

		return predictions
