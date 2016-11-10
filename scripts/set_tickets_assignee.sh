#!/bin/bash
NAME=$1
source ./.password
VIEW_URL="https://iijasd.zendesk.com/api/v2/views/38716979/tickets.json"
TICKETS=`curl -sL -u "${USERMAIL}:${PASS}" "${VIEW_URL}"`
USERID=`cat user_id  | awk -F"###" '$2 ~/'${NAME}'/ { print $1}'`

echo ${TICKETS} 						|
jq  -r '.tickets[]                                              |
select(.assignee_id == null and .submitter_id == '"${USERID}"' )| 
"\(.url)"'                                                      |
cut -c 43-51   						        |
while read TICKET_ID;
do
  curl -sL -u "${USERMAIL}:${PASS}" "https://iijasd.zendesk.com/api/v2/tickets/${TICKET_ID}.json" \
   -H "Content-Type: application/json" \
   -d '{"ticket": {"assignee_id": "'${USERID}'"} {"status": "open"}}' \
   -X PUT
done
