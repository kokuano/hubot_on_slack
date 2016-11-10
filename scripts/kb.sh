#!/bin/bash

curl -s -u "ykuniyasu@iij.com:ykuniyasu" http://db.iij-america.com/customer_db/tools/summary/si_support/index.php |sed 's:</tr>:\n:g' | grep $1 -i | grep -oP "http://.*?\"" | sed 's/\"//g' | uniq
