#!/bin/bash

source ./.password
URL="https://iijasd.zendesk.com/api/v2/organizations/64971999/users.json"

curl -sL -u "${USERMAIL}:${PASS}" "${URL}" | 
jq -r '.users[]                            | 
select(.role != "end-user")                | 
"\(.id)###\(.name)" '                      | 
sed -e 's/@iij.com//g' -e 's/ /_/g'        | 
> user_id
