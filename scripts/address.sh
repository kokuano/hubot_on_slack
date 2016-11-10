#!/bin/bash
curl -s -u "ykuniyasu@iij.com:ykuniyasu" http://db.iij-america.com/customer_db/tools/summary/si_support/index.php |sed 's:</tr>:\n:g' | grep $1 -i | grep -o "UZZ[0-9][0-9][0-9][0-9][0-9][0-9]" | uniq | xargs -I{} echo  http://db.iij-america.com/customer_db/masterid/view_masterid.php?masterID={} | uniq
