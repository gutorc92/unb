import numpy as np
import caffe
import os
import sys
import cv2
import urllib2
import urllib

dic_root = "/home/gustavo/Documents/unb/das/trabalho1"
caffe_root = "/home/gustavo/caffe"

class NetFace:
	def __init__(self):
		path = os.path.join(dic_root,"haarcascade_frontalface_alt.xml")
		self.classifier = cv2.CascadeClassifier(path)
	def classifierImage(self,miniframe):
		return self.classifier.detectMultiScale(miniframe)

class Face:
	def __init__(self,net=NetFace()):
		self.net = net
	
	def detect(self,frame):
		height, width, depth = frame.shape

		# create grayscale version
		grayscale = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
	 
		# equalize histogram
		cv2.equalizeHist(grayscale, grayscale)

		# detect objects
		DOWNSCALE = 4
		minisize = (frame.shape[1]/DOWNSCALE,frame.shape[0]/DOWNSCALE)
		miniframe = cv2.resize(frame, minisize)
		faces = self.net.classifierImage(miniframe)
		#if len(faces)>0:
			# print 'face detected!'
		#	for i in faces:
		#		x, y, w, h = [ v*DOWNSCALE for v in i ]
		#		cv2.rectangle(frame, (x,y), (x+w,y+h), (0,255,0))
		#cv2.imshow('frame',frame)
		#cv2.waitKey(0)
		#print("Faces: ", len(faces))
		return faces

class NetData:

	def __init__(self,net,transformer,labels):
		self.transformer = transformer
		self.labels = labels
		self.net = net

	def get_transformer(self):
		return self.transformer

	def get_labels(self):
		return self.labels
	
	def get_net(self):
		return self.net

class Net:

	def __init__(self,net,transformer,labels):
		self.netData = NetData(net,transformer,labels)
		self.loadsynset()

	def loadsynset(self):
		f = open("synset_cats","r")
		self.cats = f.read().splitlines()
		f.close()
		f = open("synset_dogs","r")
		self.dogs = f.read().splitlines()
		f.close()


	def predict_imageNet(self,image_filename):
		image = caffe.io.load_image(image_filename)
		self.netData.get_net().blobs['data'].data[...] = self.netData.get_transformer().preprocess('data', image)

		# perform classification
		self.netData.get_net().forward()

		# obtain the output probabilities
		output_prob = self.netData.get_net().blobs['prob'].data[0]

		# sort top five predictions from softmax output
		top_inds = output_prob.argsort()[::-1][:5]


		predictions = zip(output_prob[top_inds], self.netData.get_labels()[top_inds])

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
		return total_dogs*100,total_cats*100

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

class Output:
	
	def outFaces(self,faces):
		if(len(faces) > 0):
			print("Foram detectadas {0} faces").format(str(len(faces)))
			print("As coordendas das faces: ")
			for face in faces:
				print(face)
		else:
			print("Nao foram encontradas faces")
	
	def outAnimals(self,dogs,cats):
		if(dogs > 0):
			print("A probabilidade de haver caninos na imagem e de: {0}").format(str(dogs))
		else:
			print("Nao ha caninos na imagem")
		if(cats > 0):
			print("A probabilidade de haver felinos na imagem e de: {0}").format(str(cats))
		else:
			print("Nao ha felinos na imagem")
