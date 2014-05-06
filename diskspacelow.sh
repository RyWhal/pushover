#!/bin/bash
#Author: Ryan Whalen
#runs on a cron and checks for low disk space

#commands to run
DISK=`df -h | grep rootfs | awk '{print $2}' | egrep -o "[0-9]*"`

#if Disk space is lower than 2GB, push a notification via pushover
if [[ $DISK < 2 ]]
then
	$(pushover.sh -m "$(df -h)" -T "Disk Space Critical" -s $(date +%s))
fi
