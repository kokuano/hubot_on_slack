#!/bin/bash
NAME=$1
source ./.password
VIEW_URL="https://iijasd.zendesk.com/api/v2/views/38716979/tickets.json"
TICKETS=`curl -sL -u "${USERMAIL}:${PASS}" "${VIEW_URL}"`
USERID=`cat user_id  | awk -F"###" '$2 ~/'${NAME}'/ { print $1}'`

echo ${TICKETS}                                                 |
jq  -r '.tickets[]                                              | 
select( .assignee_id == '"${USERID}"')                          | 
"\(.subject) \(.url)" '                                         |
sed -e 's/\.json//g' -e 's:api/v2:agent:g' \
> temp_tickets

echo ${TICKETS} |
jq  -r '.tickets[]                                              |
select(.assignee_id == null and .submitter_id == '"${USERID}"' )| 
"\(.subject) \(.url)" '                                         | 
sed -e 's/\.json//g' -e 's:api/v2:agent:g' \
> temp_ticktes_null

if [ -s temp_tickets -o -s temp_tickets_null ]
	then
	echo "\`${NAME} took as follows tickets\`"
	echo ""
	cat temp_tickets temp_tickets_null 2> /dev/null
	else
	echo "\`${NAME} has no ticket\`"
	[ "${NAME}" == "nmoriya" ] && echo "\`Motto Hatarake!\`"
fi
exit 0
