pushover
========

A CLI interface tool for the pushover.net service. I made it specifically so I could build other bash applications to use it. 

The API token and User Key can either be defined in flags are hard coded into the script.


see pushover's API docs for more info: https://pushover.net/api

Usage:
========

usage string:
```
USAGE: $0 [OPTIONS]

OPTIONS:
  -h   Show this message
  -t   Define a API token
  -u   Define a user key
  -d   Choose the device
  -m   (required) - your message
  -T   Your message's title, otherwise your app's name is used
  -U   A supplementary URL to show with your message
  -r   A title for your supplementary URL, otherwise just the URL is shown
  -p   Priority (-1, 1, or 2)
  -s   a Unix timestamp of your message's date and time to display to the user, rather than the time your message is received by our API
```

Example:
```
ryan@server ~ % ./pushover.sh -m "This is a message! It pushes to my phone" -T "CLI Pushover" -p 1 -U "http://github.com/"
```

Message received!

<img src="https://cloud.box.com/shared/static/qickjqpsjh9mt8gj0kjw.jpg" alt="Drawing" width=300px/>



Resources Low
=============
resourcesLow.sh is a quick and dirty bash script made to work with my pushover.sh script. Its set up on a cron which runs every 15 minutes to notify me about resources either too low or too high.

>if 15 minute load average is > 1.00 then send a notification

>if there is less than 25Mb free memory, then send a notification

>if disk space is < 2Gb free, then send a notification


Auth Log Tail
=============
Another quick script that works with pushover notifications (pushover.sh). This script continuously tails /var/log/auth.log for authentication failures. If there is an auth failure, a pushover notification is sent via pushover.sh.

```
user@10.10.10.10 ~/Projects/pushover
 % authLogTail &
Apr 25 18:09:29 blackholeoftheinternet sshd[24995]: pam_unix(sshd:auth): authentication failure; logname= uid=0 euid=0 tty=ssh ruser= rhost=192.241.117.3  user=root
```

more scripts
============
The plan is to create more little scripts and things to use with pushover, which I will document as they come along.

