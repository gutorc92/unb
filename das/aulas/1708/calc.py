class Calc:
	def __init__(self,a,b):
		self.a = a
		self.b = b

	def sum(self):
		if(isinstance(self.a,list)):
			return [x + self.b for x in self.a]
		elif(isinstance(self.b,list)):
			return [x + self.a for x in self.b]
		elif(isinstance(self.b,list) and isinstance(self.a,list)):
			if(len(self.a) == len(self.b)):
				t = []
				for n in range(len(self.a)):
					 t.append(self.a[n] + self.b[n])
		else:
			return self.a + self.b
