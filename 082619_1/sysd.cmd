#!/bin/bash 
# copy service executables into /tmp 
cp *-daemon /tmp/
# copy unit-files into /etc/systemd/system
sudo cp *-daemon.* /etc/systemd/system/
# reload changes
sudo systemctl daemon-reload
# start services and timer
sudo systemctl start {one,two}-daemon.*
# check statuses
systemctl status {one,two}-daemon.*
# stop services and timer
sudo systemctl stop {one,two}-daemon.*
