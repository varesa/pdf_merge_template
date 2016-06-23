#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ ! -d "$1" ] || [ ! -d "$2" ]
then
	echo "Usage: convert2.sh <in_dir> <out_dir>"
	exit 1
fi

files=$(ls "$1/")
count=$(echo $files | wc -w)

i=1

echo "Converting file in $1/ to PDF $2/"

for file in $files
do
	echo -e -n "\rConverting file $i/$count"
	convert "$1/$file" -density 300 "$2/$file.pdf" >/dev/null 2>&1
	let i+=1
done

echo 
echo "Done"

