import numpy as np
import caffe
import os
import sys
import cv2
from face import Face
dic_root = "/home/gustavo/Documents/das/trabalho1"

def test():
	f = Face()
	pic = "/home/gustavo/Documents/unb/das/joserobertoarruda.jpg"
	img = cv2.imread(pic)
	img = f.detect(img)
	cv2.imshow('frame',img)
	cv2.waitKey()
	
		
