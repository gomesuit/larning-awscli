#!/bin/bash

USERNAME="webhookbot"
CHANNEL="#general"
ICON=":bike:"
WEBHOOK_URL="https://hooks.slack.com/services/XXXXXXXXXXXXXXXXXXXX"

author="author name"

data=`cat << EOF
    payload={
    "channel": "$CHANNEL",
    "username": "$USERNAME",
    "icon_emoji": "$ICON",
    "link_names": 1 ,
    "attachments": [{
        "fallback": "branchの整理をしてください",
        "color": "#003399",
        "pretext": "$PERIOD_MONTH ヶ月以上更新されて無いbranchがあります" ,
        "title": "対象branch",
        "text": "確認をお願いします @$author:"
      }]
  }
EOF`

curl -X POST --data-urlencode "$data" $WEBHOOK_URL

