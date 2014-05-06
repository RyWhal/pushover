#!/bin/bash
#Author: Ryan Whalen
#
#This script checks for high load and messages me if its high and takes a log
#of the current state of Top

#create a lockfile
lockfile -r 0 /tmp/loadchecker.lock || exit 1

#Variable declerations:

#get just the whole number of the 1min load avg. Cut off the decimal places
LOADAVG=`uptime | egrep -o '[0-9]*\.[0-9]{2}' | head -1 | cut -f 1 -d .`
SLEEP_TIME=10 #set sleep time
START=`date +%s` #set start epoch time
DIR="/var/log/loadchecker/LOG_$(date +%m%d_%H%M)" #the directory for TOP

echo $LOADAVG
#main loop
#if load is greater than 1; start the loop
if [[ $LOADAVG -gt 1 ]];
then
	mkdir -p $DIR  #make a directory for the load alert

	#push a notification to my phone about the alert
	$(pushover -m "$(uptime)" -T "Load is getting high on $(hostname)" -s $(date +%s))

	#while load is over 1 run this loop
	while true; do

		#check load again, if it recovers break from the loop and send me a notification
		LOADAVG=`uptime | egrep -o '[0-9]*\.[0-9]{2}' | head -1 | cut -f 1 -d .`
		if [[ $LOADAVG -lt 1 ]];
		then
			$(pushover -m "$(uptime)" -T "Load recovered on $(hostname)" -s $(date +%s))
			exit
		fi

		CUR_TIME=$(date +%H%M%S) #current time to name the file
		top -n1 -c -b > $DIR/top-$CUR_TIME #dump contents of a top to a file
		sleep $SLEEP_TIME #sleep for 10 seconds and do the loop again.
	done
fi
#remove the lockfile when were done
sudo rm -f /tmp/loadchecker.lock
#end


