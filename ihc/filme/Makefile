CC=pdflatex
OBJ= document.tex
CDIR=capa
DEPS= content.tex 

all: spell create clean

create: 
	$(CC) $(OBJ)

spell:
	aspell -t -c --lang=pt_br $(DEPS)
	aspell -t -c --lang=pt_br $(OBJ)
	

clean:
	rm -f *.aux *.toc $(CDIR)/*.aux 
