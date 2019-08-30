#!/bin/bash
# 1. run 3 x "sleep"
sleep 1000 & pid=$!; sleep 2000 & sleep 3000 &
# 2. Ctrl+Z will send SIGSTOP to currently running "sleep", if we omit the last "&"
# then stop second job
kill -STOP %-
# and finally stop first job by PID
kill -19 $pid
# also we can stop'em all with
kill -STOP $(jobs -p)
# 3. Check statuses and show PIDs
jobs -l
# 4. Terminate active: (-TERM=-15 is default action)
kill %
# 5. Continue:
kill -CONT %
kill -18 %-
# 6. Killing last two jobs:
kill -KILL %2
kill -9 $pid
jobs -l
