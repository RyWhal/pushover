# Pushover


A CLI interface tool for the pushover.net service. I made it specifically so I could build other bash applications to use it. 

The API token and User Key can either be defined in flags are hard coded into the script.


see pushover's API docs for more info: https://pushover.net/api

## Usage


usage string:
```
USAGE: pushover.sh [OPTIONS]

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

<img src="http://ryanwhalen.me/static/pushover.png" alt="Drawing" width=300px/>


## Scripts using pushover


### disk space low
resourcesLow.sh is a quick script to alert via pushover me if disk space is < 2Gb free


### Auth Log Tail
authlogtail.sh works with pushover notifications (pushover.sh), and continuously tails /var/log/auth.log for authentication failures. If there is an auth failure, a pushover notification is sent via pushover.sh.

```
user@10.10.10.10 ~/Projects/pushover
 % authLogTail &
Apr 25 18:09:29 blackholeoftheinternet sshd[24995]: pam_unix(sshd:auth): authentication failure; logname= uid=0 euid=0 tty=ssh ruser= rhost=192.241.117.3  user=root
```

### Load Checker
loadchecker.sh is set up on a cron to go off once a minute and checks the one minute system load average. If the load avg is greater than 1, it kicks off a loop that checks load every 10 seconds. Everytime load > 1, a full dump of a "top" is logged.
The script sends a pushover notification when it first detects high load, and again when it recovers.


### Mem checker
memchecker.sh is set up like loadchecker.sh. A cron goes off every minute and alerts me if memory is less than 50Mb free. It will send another alert when it recovers.

### The Crons 
These is my crontab file. These are what I use to initiate these scripts (except authlogtail.sh, that runs in the background). You either need to make sure that your user has access to /tmp to remove the files or run the crons as the root user.

```
* 0 * * * /bin/diskspacelow.sh
* * * * * /bin/loadchecker.sh
* * * * * /bin/memchecker.sh
```
