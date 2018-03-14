#!/bin/bash

if [ "$#" -ne 3 ]; then
	echo "usage: ./recordImage.sh <current mag11> <current mag2> <location of probe> <magnetic field>"
else
	/home/pi/karlCode/killVideoStream.sh
	/home/pi/karlCode/recordImage.sh "$1" "$2" "$3" "$4"
	/home/pi/karlCode/startVideoStream.sh	
fi

