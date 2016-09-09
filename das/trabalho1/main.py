import sys
from models import Input,Net,Face,Output
import cv2

def main(argv=sys.argv):
	f = Face()
	n = Net()
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
