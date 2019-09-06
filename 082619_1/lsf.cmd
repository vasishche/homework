#!/bin/bash
# run sleep
sleep 10000 1>1.out 2>2.out & pid=$!
# list all files connected with this PID
lsof -p $pid
# show only stdout file
lsof -a -p $pid -d 1
# list all ESTABLISHED TCP connections
sudo lsof -i TCP -sTCP:ESTABLISHED
