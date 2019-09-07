#!/bin/bash
# add students group
sudo groupadd -g 5000 students
# add 3 users
eval "sudo useradd -g 5000 -N "{glen,antony,lesly}";"
# we need passwords to su and check students directory behavior
eval "echo -e 'goodpass\ngoodpass' | sudo passwd "{glen,antony,lesly}";"
# create students directory with ug access to write and delete files and SGID
sudo mkdir /home/students
sudo chown root:students /home/students/
sudo chmod 2770 /home/students/
# create data1 directory with sticky bit
sudo mkdir /data1
sudo chmod 1777 /data1
