#!/bin/bash

USERNAME="webhookbot"
CHANNEL="#general"
ICON=":bike:"
WEBHOOK_URL="https://hooks.slack.com/services/XXXXXXXXXXXXXXXXXXXXX"

author="author name"

last_used=`./get-last-used.sh`
fff='```'
text=`cat << EOF
$fff
$last_used
$fff
EOF`

data=`cat << EOF
    payload={
    "channel": "$CHANNEL",
    "username": "$USERNAME",
    "icon_emoji": "$ICON",
    "link_names": 1 ,
    "attachments": [{
        "fallback": "branchの整理をしてください",
        "color": "#003399",
        "pretext": "$text" ,
        "title": "対象branch",
        "mrkdwn_in": ["text", "pretext"],
        "text": "確認をお願いします @$author:"
      }]
  }
EOF`

curl -X POST --data-urlencode "$data" $WEBHOOK_URL

