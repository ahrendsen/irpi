#!/bin/bash

if [ "$#" -gt 5 ]; then
	echo "usage: ./recordImageAndSendToRbPi.sh"
	echo "       ./recordImageAndSendToRbPi.sh <fileName>"
	echo "       ./recordImageAndSendToRbPi.sh <fileName> <shutterSpeed> <ISO>"
else
	BASEDIR=/home/pi/RbPics/RbAutoPics
	DATE=$(date +%y-%m-%d_%H%M%S)
	NAME=image$DATE
	if [ "$#" -eq 1 ]; then 
		NAME=$1
		sudo /home/pi/karlCode/recordImage.sh $NAME
	elif [ "$#" -eq 3 ]; then 
		#echo "recordImageAndSendToPi sending SS args"
		SS=$1
		ISO=$2
		NAME=$3
		sudo /home/pi/karlCode/recordImage.sh $NAME -ss $SS -ISO $ISO 
	fi
	sudo scp -i /home/pi/.ssh/id_rsa $BASEDIR/$NAME.jpg pi@rbpi:RbPictures/$NAME.jpg
fi
