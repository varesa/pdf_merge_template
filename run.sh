#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ ! -f "$1" ] || [ ! -f "$2" ]
then
	echo "Usage: run.sh <template> <multi-page>"
	exit 1
fi 

if [ ! -d "out/" ]
then
	mkdir out
fi


tmp1=$(mktemp -d)
./split.sh "$2" "$tmp1/"


tmp2=$(mktemp -d)
./convert.sh "$tmp1/" "$tmp2/"

tmp3=$(mktemp -d)
convert -verbose -density 300 "$1" -quality 100 -sharpen 0x1.0 "$tmp3/template.png" >/dev/null 2>&1

./merge.sh "$tmp3/template.png" "$tmp2/" "out/"

echo rm -rf $tmp1
echo rm -rf $tmp2
echo rm -rf $tmp3 
