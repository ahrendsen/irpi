#!/bin/bash
YEAR=$(date +%Y)
MONTH=$(date +%m)
DAY=$(date +%d)
BASEDIR=/home/pi/RbPics/RbAutoPics

if [ "$#" -ne 1 ]; then
	echo "Don't forget that you can provide a filename as an argument!"
	FILENAME="image$(date +%m-%d-%y_%H%M%S)"
	sudo /home/pi/karlCode/killVideoStream.sh
	sudo /home/pi/karlCode/recordImage.sh $FILENAME
	sudo /home/pi/karlCode/startVideoStream.sh	
else
	FILENAME=$1
	sudo /home/pi/karlCode/killVideoStream.sh
	sudo /home/pi/karlCode/recordImage.sh $FILENAME
	sudo /home/pi/karlCode/startVideoStream.sh	
fi
