#!/bin/bash

declare -A appUsers
declare -A allUsers

while [ -f /tmp/user.list ]; do

	appUsers=()
	while read vuser; do
		appUsers["$vuser"]=1
	done < /tmp/user.list

	allUsers=()
	while read vuser vpid; do
		allUsers[$vpid]=$vuser
	done < <(who -u | awk '{print $1,$6}')

	for ipid in "${!allUsers[@]}"; do
		if [ "${appUsers[${allUsers[$ipid]}]}" != "1" ]; then
			kill -HUP "$ipid"
			echo "User \"${allUsers[$ipid]}\" (PID=$ipid) was disconnected."
		fi
	done
	sleep 15

done

echo "File with approved user list is unavailable. Service stoped."
