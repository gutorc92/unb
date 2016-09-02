import numpy as np
import caffe
import os
import sys
import cv2

dic_root = "/home/gustavo/Documents/unb/das/trabalho1"

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
