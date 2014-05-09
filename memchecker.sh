#!/bin/bash
#Author: Ryan Whalen
#
#This script checks for low memory and messages me if its high and takes a log
#of the current state of Top

#create a lockfile
lockfile -r 0 /tmp/memchecker.lock || exit 1

#Variable declerations:

#get just the amount of Megs of memory free
MEM=$(free -m | awk '{print $4}' | sed -n 3p)
SLEEP_TIME=10 #set sleep time
START=$(date +%s) #set start epoch time

#main loop
#if load is greater than 1; start the loop
if [[ $MEM -lt 50 ]];
then
	#push a notification to my phone about the alert
	$(pushover -m "$(free -m)" -T "Memory is getting low on $(hostname)" -s $(date +%s))

	#while load is over 1 run this loop
	while true; do

		#check load again, if it recovers break from the loop and send me a notification
		MEM=`free -m | awk '{print $4}' | sed -n 3p`
		if [[ $MEM -gt 50 ]];
		then
			$(pushover -m "$(free -m)" -T "Memory recovered on $(hostname)" -s $(date +%s))
			exit
		fi

		sleep $SLEEP_TIME #sleep for 10 seconds and do the loop again.
	done
fi
#remove the lockfile when were done
rm -f /tmp/memchecker.lock
#end


