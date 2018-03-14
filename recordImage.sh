#!/bin/bash

if [ "$#" -gt 5 ]; then
	echo "usage: sudo ./recordImage.sh"
	echo "       sudo ./recordImage.sh <fileName>"
	echo "       sudo ./recordImage.sh <fileName> <options>"
else
	BASEDIR=/home/pi/RbPics/RbAutoPics
	NAME="image$(date +%m-%d-%y_%H%M%S)"
	if [ "$#" -lt 2 ]; then 
		NAME=$1
		raspistill -o $BASEDIR/$NAME.jpg 
	elif [ "$#" -eq 5 ]; then
		#echo "recordImage sending SS args"
		NAME=$1
		OPTION1NAME=$2
		OPTION1VALUE=$3
		OPTION2NAME=$4
		OPTION2VALUE=$5
		raspistill "$OPTION1NAME" "$OPTION1VALUE" "$OPTION2NAME" "$OPTION2VALUE" -o $BASEDIR/$NAME.jpg 
	fi
fi

