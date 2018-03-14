#!/bin/bash

if [ "$#" -lt 1 ]; then
	echo "usage: ./takePicture.sh"
	echo "       ./takePicture.sh <fileName>"
	echo "       ./takePicture.sh <shutterSpeed> <ISO> <fileName>"
else
	BASEDIR=/home/pi/RbPics/RbAutoPics
	DATE=$(date +%y-%m-%d_%H%M%S)
	NAME=$DATE
	if [ "$#" -eq 1 ]; then 
		NAME=$1
		sudo /home/pi/karlCode/killVideoStream.sh
		sudo /home/pi/karlCode/recordImageAndSendToRbPi.sh "$NAME"
		sudo /home/pi/karlCode/startVideoStream.sh	
	elif [ "$#" -eq 3 ]; then 
		#echo "takeRemotePicture sending SS args"
		SS=$1
		ISO=$2
		NAME=$3
		sudo /home/pi/karlCode/killVideoStream.sh
		sudo /home/pi/karlCode/recordImageAndSendToRbPi.sh $SS $ISO "$NAME"
		sudo /home/pi/karlCode/startVideoStream.sh	
	fi
fi

