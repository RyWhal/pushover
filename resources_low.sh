#!/bin/bash
#Author: Ryan Whalen

#commands to run
MEMFREE=`free -m | awk '{print $4}' | sed -n 2p`
LOAD=`uptime | sed 's/.*load average: //' | awk -F\, '{print $3}'`
DISK=`df -h | grep rootfs | awk '{print $2}' | egrep -o "[0-9]*"`

#if memory free is less than 25 Mb then push a notification via "pushover"
if [[ $MEMFREE -lt 25 ]]
then
	$(pushover -m "$(free -m)" -T "Server Memory Critical" -s $(date +%s))
fi

#if 15 minute  load Avg is greater than 1, push a notification via pushover
if [[ $LOAD > 1.00 ]]
then
	$(pushover -m "$(uptime)" -T "Server Load Critical" -s $(date +%s))
fi

#if Disk space is lower than 2GB, push a notification via pushover
if [[ $DISK < 2 ]]
then
	$(pushover -m "$(df -h)" -T "Disk Space Critical" -s $(date +%s))
fi
