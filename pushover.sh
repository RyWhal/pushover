#!/bin/bash
#Author: Ryan Whalen
#2014

#function for usage statement. Called later in the script
usage()
{
cat << EOF
USAGE: $0 [OPTIONS]

OPTIONS:
  -h   Show this message
  -t   Define a API token (if its not hard coded in this file)
  -u   Define a user key  (if its not hard coded in this file)
  -d   Choose the device
  -m   (required) - your message
  -T   Your message's title, otherwise your app's name is used
  -U   A supplementary URL to show with your message
  -r   A title for your supplementary URL, otherwise just the URL is shown
  -p   Priority (-1, 1, or 2)
  -s   a Unix timestamp of your message's date and time to display to the user, rather than the time your message is received by our API
EOF
}


# Default config vars
PUSHOVER_URL="https://api.pushover.net/1/messages"
TOKEN="" #add your pushover API token here
USER_KEY="" #add your specific user key here

##establish some variables
##set some default variables if you please
MESSAGE=""
DEVICE=""
TITLE=""
URL=""
URL_TITLE=""
PRIORITY=-1 ##-1=quiet notifications, 1=high priority, 2=requires confirmation
TIMESTAMP=""

#if there are no varibales print the usage satement and exit
if [[ $# -eq 0 ]]
then
	usage
	exit 1
fi

#getopt to get parameters
while getopts "ht:d:u:m:T:U:r:p:s:" option; do
	case $option in
		h)
			usage
			exit 1
			;;
		t)
			TOKEN="$OPTARG"
			;;
		u)
			USER_KEY="$OPTARG"
			;;
		d)
			DEVICE="$OPTARG"
			;;
		m)
			MESSAGE="$OPTARG"
			;;
		T)
			TITLE="$OPTARG"
			;;
		U)
			URL="$OPTARG"
			;;
		r)
			URL_TITLE="$OPTARG"
			;;
		p)
			PRIORITY="$OPTARG"
			#if priority isnt -1,1,or2 set it to 1
			if ([[ $PRIORITY -ne -1 ]] | [[ $PRIORITY -ne 1 ]] | [[ $PRIORITY -ne 2 ]])
			then
				PRIORITY=1
			fi
			;;
		s)
			TIMESTAMP="$OPTARG"
			;;
		?)
			#print usage if there is an unknown variable
			usage
			exit
			;;
	esac
done

#run the actual curl command
`curl -s \
	-F "token=$TOKEN" \
	-F "user=$USER_KEY" \
	-F "device=$DEVICE" \
	-F "message=$MESSAGE" \
	-F "title=$TITLE" \
	-F "url=$URL" \
	-F "url_title=$URL_TITLE" \
	-F "priority=$PRIORITY" \
	-F "timestamp=$TIMESTAMP"\
	$PUSHOVER_URL`
