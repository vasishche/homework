#!/bin/bash
# by analogy with the second task
awk 'BEGIN{OFS="\""}; {print $4,$1,$0}' access.log | awk -F\" '{reqn[substr($1,2,2)" "substr($1,5,3)" "substr($1,9,4)" "substr($1,14,2)":"substr($1,17,1)"X:XX "$2" "$4]++};END{for (i in reqn) if (reqn[i]>50) print reqn[i]" "i}' | sort -hr > extra.res
# first 3 lines of the output file:
# reqs  DD M M YYYY HH:MX:XX IP            URL
# 18047 03 May 2019 14:0X:XX 161.9.192.11 GET /apache-log/access.log HTTP/1.1
# 16002 27 Jun 2018 06:3X:XX 5.112.235.245 GET /apache-log/access.log HTTP/1.1
# 15643 27 Jun 2018 06:4X:XX 5.112.235.245 GET /apache-log/access.log HTTP/1.1
