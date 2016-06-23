#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ ! -f "$1" ] || [ ! -d "$2" ]
then
	echo "Usage: split.sh <file_in> <dir_out>"
	exit 1
fi

pages=$(qpdf --show-npages "$1")

echo "Extracting $pages pages from $1 to $2"

for i in $(seq 1 $pages)
do
	printf -v pad "%03d" $i
	echo -n -e "\rExtracting page $i/$pages"
	qpdf "$1" --pages "$1" $i -- "$2/page-$pad.pdf"
done

echo -e "\nComplete"
