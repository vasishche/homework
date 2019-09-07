#!/bin/bash
# add sales group
sudo groupadd -g 4000 sales
# add 3 users
eval "sudo useradd -g 4000 -N "{bob,alice,eve}";"
# change user passwords
eval "echo -e 'goodpass\ngoodpass' | sudo passwd "{bob,alice,eve}";"
# new accounts password lifetime
sudo sed -i.backupfile -r "s/(^PASS_MAX_DAYS\t).*/\130/g" /etc/login.defs 
# bob, alice, eve expires in 90 day
eval "sudo usermod -e `date -d "90 days" +"%Y-%m-%d"` "{bob,alice,eve}";"
# Bob password lifetime
sudo chage -M 15 bob
# expire password, user must change it on the next login
eval "sudo passwd -e "{bob,alice,eve}";"
