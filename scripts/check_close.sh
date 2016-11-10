#!/bin/bash

source ./.password
VIEW_URL="https://iijasd.zendesk.com/api/v2/views/52105883/tickets.json"
TICKETS=`curl -sL -u "${USERMAIL}:${PASS}" "${VIEW_URL}"`


# Check assigned ticket
echo ${TICKETS}                                                                          | 
jq  -r '.tickets[]                                                                       | 
select( .assignee_id != null )                                                           | 
"\(.assignee_id)###\(.created_at | fromdate + 75600 | todate)###\(.subject)###\(.url)" ' | 
sed -e 's/\.json//g' -e 's:api/v2:agent:g' \
> temp_tickets

# Check unassigned ticket
echo ${TICKETS}                                                                          | 
jq  -r '.tickets[]                                                                       | 
select( .assignee_id == null )                                                           | 
"\(.submitter_id)###\(.created_at | fromdate + 75600 | todate)###\(.subject)###\(.url)" '| 
sed -e 's/\.json//g' -e 's:api/v2:agent:g' \
> temp_tickets_null


cat user_id 									         | 
awk -F"###" '{ print "sed -i \"s/"$1"/"$2"/g\" temp_tickets temp_tickets_null" }'        | 
bash

cat temp_tickets temp_tickets_null           					         | 
awk -F"###" '{ print $3"###"$4 > "member/"$1}'

[ -s temp_tickets ] || [ -s temp_tickets_null ] && \
echo "!!! Please check and close if already completed !!!"

# Sort by member name
for var in member/* 
do
	if [ `echo ${var} | grep "[0-9]" ` ]
		then echo "\`unknown\`"
		else echo "\`${var/member\/}\`"
	fi
	cat "${var}" | awk -F"###" '{print ">Subject: "$1,$2"\n" }'
done

rm -f temp_tickets* member/*
