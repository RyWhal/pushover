#!/bin/bash
#Author: Ryan Whalen

sudo tail -fn0 /var/log/auth.log | \
while read line; do
	echo "$line" | grep 'pam_unix(sshd:auth): authentication failure'
	if [[ $? = 0 ]]
    then
		$(pushover -m "$line" -T "Failed login attempt" -s $(date +%s))
    fi
done
