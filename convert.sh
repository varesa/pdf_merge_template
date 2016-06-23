#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ ! -d "$1" ] || [ ! -d "$2" ]
then
	echo "Usage: convert.sh <in_dir> <out_dir>"
	exit 1
fi

files=$(ls "$1/")
count=$(echo $files | wc -w)

i=1

for file in $files
do
	echo -e -n "\rConverting file $i/$count"
	convert -verbose -density 300 "$1/$file" -quality 100 -sharpen 0x1.0 "$2/$file.png" >/dev/null 2>&1
	let i+=1
done

echo 
echo "Done"

