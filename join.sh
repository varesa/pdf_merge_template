#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ ! -d "$1" ]
then
	echo "Usage: join.sh <dir_in> <file_out>"
	exit 1
fi


echo "Joining $1/* to $2"


pages=$(ls $1/*)
qpdf --empty --pages $pages -- "$2"

echo "Done"
