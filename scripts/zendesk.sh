#!/bin/bash

source ./.password
curl -sL -u "${USERMAIL}:${PASS}" https://iijasd.zendesk.com/api/v2/views/47293893/tickets.json | jq  -r '.tickets[] | "","+-----------\(.created_at | fromdate + 75600 | todate)------------------","Subject:  \(.subject)","Status:   \(.status)","-------------------------------------------------+","\(.url)","","" ' | sed -e 's/\.json//g' -e 's:api/v2:agent:g'
