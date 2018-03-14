#!/bin/bash

if [ $(pgrep raspistill) ]; then
	kill $(pgrep raspistill)
fi
