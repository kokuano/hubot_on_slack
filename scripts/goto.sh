#!/bin/bash

# Refer to " https://developer.citrixonline.com/api/gotoassist-rs-api/apimethod/get-all-sessions "
# author: ykuniyasu@iij.com
# created date: 10/31/2016

# set time as GMT
FROMDATE=`/bin/date '+%Y-%m-%dT%H:%M:%SZ' -d '4 hours 30 minutes ago  '`
TODATE=`  /bin/date '+%Y-%m-%dT%H:%M:%SZ' -d '4 hours'`
URL="https://api.citrixonline.com/G2A/rest/v1/sessions?sessionType=SCREEN_SHARING&fromTime=${FROMDATE}&toTime=${TODATE}"
ACCESS_TOKEN=("URAYVFBnJnHKJQ59HWuQcDoKTbmw" "jecy3FYffITGpsajA9k6p5KcS2R0" "qZX7j7rQ3weMHnNiU7gTQ3Itk4XK")
AVA=()
USED=()

# check every account status
for i in 0 1 2
do
	_ACCESS_TOKEN="${ACCESS_TOKEN[i]}"
	ACCOUNT_NAME="gotoassist-0$(( ${i} + 1 ))@iij-america.com"
	_TEMP=$(curl -s "${URL}" -H "Accept:application/json" -H "Content-Type:application/json" -H "Authorization:OAuth oauth_token=${_ACCESS_TOKEN}"  | jq ' .sessions[] | select( (.status == "active" ) or ( .status == "waiting") ) | .expertEmail ' -r )
	if [ "${_TEMP}" == "${ACCOUNT_NAME}" ]
		then USED+="${ACCOUNT_NAME} "
		else  AVA+="${ACCOUNT_NAME} "
	fi
done

# output
echo "Available:"
echo "${AVA[@]}"  | sed 's/\s/ \n/g'
echo "Used:"
echo "${USED[*]}" | sed 's/\s/ \n/g'
