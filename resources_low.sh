#!/bin/bash
#Author: Ryan Whalen

MEMFREE=`free -m | awk '{print $4}' | sed -n 3p`
LOAD=`uptime | sed 's/.*load average: //' | awk -F\, '{print $3}'`
DISK=`df -h | grep rootfs | awk '{print $2}' | egrep -o "[0-9]*"`

if [[ $MEMFREE -lt 25 ]]
then
	$(pushover -m "$(free -m)" -T "Server Memory Critical" -s $(date +%s))
fi

if [[ $LOAD > 1.00 ]]
then
	$(pushover -m "$(uptime)" -T "Server Load Critical" -s $(date +%s))
fi

if [[ $DISK < 2 ]]
then
	$(pushover -m "$(df -h)" -T "Disk Space Critical" -s $(date +%s))
fi
