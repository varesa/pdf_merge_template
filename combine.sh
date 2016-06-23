#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ ! -f "$1" ] || [ ! -d "$2" ] || [ ! -d "$3" ]
then
	echo "Usage: combine.sh <template_file> <input_dir> <output_dir>"
	exit 1
fi

echo "Merging files from $2 with $1 to $3"

size=$(identify -format "%[fx:w]x%[fx:h]" "$1")

infiles=$(ls "$2/")

count=$(echo $infiles | wc -w)
i=1

for file in $infiles
do
	echo -e -n "\rMerging file $i/$count"
	convert \
		-page +0+0 "$1" \
		-page +0+0 "$2/$file" \
		-background white \
		-layers merge "$3/merged-$file"
	let i+=1		
done

echo ""
echo "Complete"
