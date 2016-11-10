#!/bin/bash

curl -s -u "ykuniyasu@iij.com:ykuniyasu" http://db.iij-america.com/customer_db/tools/summary/si_support/index.php |sed 's:</tr>:\n:g' | grep ${1} -i | sed 's:</td>:\n:g'  | awk -F">" 'NR == 5 {print ">1st: "$2} NR == 6 {print ">2nd: "$2} NR == 7{print ">3rd: "$2}' | awk -F"@" '{print $1}'
