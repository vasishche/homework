#!/bin/bash
# I don't know the best way to do it with sed, so I start with awk. This create additional file mask.txt with IPs and it mask
awk '/'^[1-9]+\.[1-9]+\.[1-9]+\.[1-9]+'/{if (ipnum[$1]++==0) ipmask[$1]="ip"++ctr; $1=ipmask[$1]; print $0}; END{for (i in ipmask) print ipmask[i]" - "i > "mask.res"}' access.log > access.log.tmp && mv access.log.tmp access.log
# Now with sed: delete empty strings, numerating other, then replacing: number\nip -> "ip"number
sed -i -r -e '/^$/d;=' access.log && sed -i -r -e 'N;s/([0-9]+)\n[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ip\1/g' access.log
