#!/bin/bash
sudo systemctl stop ext-daemon
sudo rm /etc/systemd/system/ext-daemon.service
sudo systemctl daemon-reload
rm /tmp/{user.list,ext-daemon.cmd}
