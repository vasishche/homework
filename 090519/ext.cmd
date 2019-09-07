#!/bin/bash
# create list of approved users (e.g., current user and root)
who am i | cut -d" " -f1 >> /tmp/user.list && echo "root" >> /tmp/user.list
# copy service unit
sudo cp ext-daemon.service /etc/systemd/system
# copy daemon executable
cp ext-daemon.cmd /tmp
# launch service
sudo systemctl daemon-reload
sudo systemctl start ext-daemon
# now we can try slogin user@localhost
