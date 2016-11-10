#!/bin/bash

IP_ADDRESS=()
HERE=()
OUT=()
MEMBER_HOSTNAME=("htamaki" "nmoriya1" "ykuniyasu" "mamano" "mtakamura" "habe" "yhidaka" "kfujita")
for i in ` echo ${MEMBER_HOSTNAME[*]} `
do
        IP_ADDRESS=(`dig iija-${i}.iij.com +short&`)
        for j in ` echo ${IP_ADDRESS[*]}`
        do
                ping -c 1 -w 1 ${j} > /dev/null  && break
        done
        if [ $? = 0 ]; then
		HERE+=( ${i} )
                else OUT+=( ${i} )
        fi
done
echo "In office:"
echo " `echo ${HERE[@]} | sed 's/\s/\n /g' `"
echo ""
echo "out of office:"
echo " `echo ${OUT[@]} | sed 's/\s/\n /g' `"

