#!/bin/bash
# I found 3 ways
awk -F\" '{print $6}' access.log | sort | uniq -c | sort -fhr | head -n 1
# This is almost the same
awk -F\" '{print $6 | "sort | uniq -c | sort -fhr | head -n 1"}' access.log
# This is the fastest
awk -F\" '{varn[$6]+=1} END{max=0; amax=""; for (i in varn) if (varn[i]>max) { amax=i; max=varn[i] } print max" - "amax}' access.log
# The same result:
#1033047 - Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko
#1033047 Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko
