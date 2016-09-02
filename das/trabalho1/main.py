import sys
from models import Input,Net,Face
import cv2

def main(argv=sys.argv):
	print(argv)
	f = Face()
	n = Net()
	if(len(argv) >= 2):
		d = Input(argv[1])
		f.frame = d.getImage(Input.FACES)
		faces = f.result()
		dogs,cats = n.result(d.getImage(Input.PREDICTION))
		dogs = dogs * 100
		cats = cats * 100
		print(" ".join(["Foram detectadas ", str(len(faces)), "faces","probabilidade de felinos:",str(cats),"probabilidade de canindos:",str(dogs)])) 	
		print("As coordenadas da(s) face(s) so: ")
		for face in faces:
			print(face)

if __name__=="__main__":
	main()
