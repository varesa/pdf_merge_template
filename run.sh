#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ ! -f "$1" ] || [ ! -f "$2" ]
then
	echo "Usage: run.sh <template> <multi-page> <output>"
	exit 1
fi 


# Split multi-page to separate pdf files
tmp1=$(mktemp -d)
./split.sh "$2" "$tmp1/"


# Convert template pdf to png
tmp2=$(mktemp -d)
convert -verbose -density 300 "$1" -quality 100 -sharpen 0x1.0 "$tmp2/template.png" >/dev/null 2>&1


# Convert pages to png
tmp3=$(mktemp -d)
./convert.sh "$tmp1/" "$tmp3/"


# Combine pages with template
tmp4=$(mktemp -d)
./combine.sh "$tmp2/template.png" "$tmp3/" "$tmp4/"


# Convert back to pdf
tmp5=$(mktemp -d)
./convert2.sh "$tmp4/" "$tmp5/"

# Join pages to a single file
./join.sh "$tmp5/" "$3"


# Cleanup
rm -rf $tmp1 $tmp2 $tmp3 $tmp4 $tmp5
