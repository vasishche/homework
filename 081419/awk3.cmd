#!/bin/bash
# Total amount of data per IP
awk '{ipdata[$1]+=$10}; END{for (i in ipdata) print ipdata[i]" bytes for "i}' access.log | sort -hr
# First tree strings of output:
# 837767255708 bytes for 89.139.63.192
# 37632400416 bytes for 66.181.167.143
# 31327886000 bytes for 95.31.149.117
