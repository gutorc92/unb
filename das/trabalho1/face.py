import numpy as np
import caffe
import os
import sys
import cv2

dic_root = "/home/gustavo/Documents/das/trabalho1"

class Face:

	
	def detect(self,frame):
		height, width, depth = frame.shape

		# create grayscale version
		grayscale = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
	 
		# equalize histogram
		cv2.equalizeHist(grayscale, grayscale)

		# detect objects
		classifier = cv2.CascadeClassifier(os.path.join(dic_root,"haarcascade_frontalface_alt.xml"))
		DOWNSCALE = 4
		minisize = (frame.shape[1]/DOWNSCALE,frame.shape[0]/DOWNSCALE)
		miniframe = cv2.resize(frame, minisize)
		faces = classifier.detectMultiScale(miniframe)
		if len(faces)>0:
			# print 'face detected!'
			for i in faces:
				x, y, w, h = [ v*DOWNSCALE for v in i ]
				cv2.rectangle(frame, (x,y), (x+w,y+h), (0,255,0))
		return frame	
