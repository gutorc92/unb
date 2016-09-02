import numpy as np
import caffe
import os
import sys
import cv2
import urllib2
import urllib

dic_root = "/home/gustavo/Documents/unb/das/trabalho1"
caffe_root = "/home/gustavo/caffe"

class Face:
	
	def __init__(self,frame=None):
		self.faces = None
		self.frame = frame
		path = os.path.join(dic_root,"haarcascade_frontalface_alt.xml")
		self.classifier = cv2.CascadeClassifier(path)

	def detect(self):
		height, width, depth = self.frame.shape

		# create grayscale version
		grayscale = cv2.cvtColor(self.frame, cv2.COLOR_BGR2GRAY)
	 
		# equalize histogram
		cv2.equalizeHist(grayscale, grayscale)

		# detect objects
		DOWNSCALE = 4
		minisize = (self.frame.shape[1]/DOWNSCALE,self.frame.shape[0]/DOWNSCALE)
		miniframe = cv2.resize(self.frame, minisize)
		faces = self.classifier.detectMultiScale(miniframe)
		self.faces = faces

	def result(self):
		if not(self.faces): self.detect()
		return self.faces

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
		self.loadsynset()

	def create_labels(self):
		labels_file = os.path.join(caffe_root, 'data','ilsvrc12','synset_words.txt')
		self.labels = np.loadtxt(labels_file, str, delimiter='\t') 
		

	def loadsynset(self):
		f = open("synset_cats","r")
		self.cats = f.read().splitlines()
		f.close()
		f = open("synset_dogs","r")
		self.dogs = f.read().splitlines()
		f.close()


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

	def result(self,img):
		predictions = self.predict_imageNet(img)
		total_dogs = 0
		total_cats = 0
		for per, cls in predictions:
			if cls.split()[0] in self.cats:
				total_cats += per
			elif cls.split()[0] in self.dogs:
				total_dogs += per		
		return total_dogs,total_cats

class Input:

	FACES = 1
	PREDICTION = 2
	def __init__(self, load=None):
		self.img = None
		if(load): self.resolve(load)

	def resolve(self,load):
		if(self.isFile(load)):
			self.fileResolver(load)	
		elif(self.isUrl(load)):
			self.urlResolver(load)

	def isFile(self,load):
		return os.path.isfile(load)
	def isUrl(self,load):
		try:
			urllib2.urlopen(load)
			return True
		except urllib2.HTTPError, e:
			return False
		except urllib2.URLError, e:
			return False
		return False
			
	def fileResolver(self,load):
		self.img = cv2.imread(load)
		self.load = load

	def urlResolver(self,load):
		image = urllib.URLopener()
		path = os.path.join(dic_root,"0000001.jpg")
		image.retrieve(load,path)
		image.close()
		self.fileResolver(path)
		return None
	
	def getImage(self,destination):
		if(destination == self.FACES):
			return self.img
		else:
			return self.load
