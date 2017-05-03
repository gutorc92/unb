CC=pdflatex
OBJ= document.tex
CDIR=capa

all: spell create clean

create: 
	$(CC) $(OBJ)

spell:
	./check_files.sh

clean:
	rm -f *.aux *.toc $(CDIR)/*.aux 
