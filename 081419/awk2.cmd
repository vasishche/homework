#!/bin/bash
# 1st method
awk '/'1+\.1+\.1+\.1+'/ {print $4}' access.log | awk -F/ '{print $2":"$3}' | awk -F: '{print $1" "$2}' | sort | uniq -c | sort -k3 -k2M
# 2nd method
awk '/'1+\.1+\.1+\.1+'/ {reqn[substr($4,5,3)" "substr($4,9,4)]++}; END{for (i in reqn) print i" - "reqn[i]" reqs"}' access.log | sort -k2,2 -k1M
# First three output lines:
# Dec 2015 - 253 reqs
# Jan 2016 - 6 reqs
# Feb 2016 - 673 reqs
