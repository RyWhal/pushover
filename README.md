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

<img src="https://cloud.box.com/shared/static/qickjqpsjh9mt8gj0kjw.jpg" alt="Drawing" style="width: 100px;"/>

