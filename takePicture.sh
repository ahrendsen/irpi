#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Don't forget that you can provide a filename as an argument!"
	sudo /home/pi/karlCode/killVideoStream.sh
	sudo /home/pi/karlCode/recordImage.sh
	sudo /home/pi/karlCode/startVideoStream.sh	
else
	FILENAME=$1
	sudo /home/pi/karlCode/killVideoStream.sh
	sudo /home/pi/karlCode/recordImage.sh $FILENAME
	sudo /home/pi/karlCode/startVideoStream.sh	
fi
