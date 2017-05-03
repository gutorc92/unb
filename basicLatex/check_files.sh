#!/bin/bash
#find -name "*.tex"
files=$(find -name "*.tex")
for f in $files
do
	aspell -t -c --lang=pt_br $f
    #echo $f
done
