#!/bin/bash
# I find 3 ways
# condition with regexp
i=0
lines=()
while read line ; do
	if ! [[ "$line" =~ [a]+ ]]; then
		lines+=("$line")
		echo "$line"
	fi
done < sec.txt
echo "${#lines[@]}"
# condition with pattern
i=0
lines=()
while read line ; do
	if [[ "$line" != @(*a*) ]]; then
		lines+=("$line")
		echo "$line"
	fi
done < sec.txt
echo "${#lines[@]}"
# without cycle: read all, delete by pattern, print
IFS=$'\n'
lines=(`cat "sec.txt"`)
IFS=
lines=( ${lines[@]/*a*/} )
printf "%s\n" "${lines[@]}"
echo "${#lines[@]}"
