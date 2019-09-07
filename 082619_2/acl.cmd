#!/bin/bash
# create cases directory and 2 case files
sudo mkdir -p /shares/cases
sudo touch /shares/cases/{murders,moriarty}.txt
# create bakerstreet group with its users
sudo groupadd bakerstreet
eval 'username='{holmes,watson}';password=`openssl rand 14 -base64`;echo "$username:$password::bakerstreet::/home/$username:/bin/bash" | sudo newusers && echo "$username $password">>user.pass;'
# create scotlandyard group with its users
sudo groupadd scotlandyard
eval 'username='{lestrade,gregson,jones}';password=`openssl rand 14 -base64`;echo "$username:$password::scotlandyard::/home/$username:/bin/bash" | sudo newusers && echo "$username $password">>user.pass;'
# set acl for bakerstreet assuming that others can have 0 default permitions
sudo setfacl -m g:bakerstreet:x /shares/
sudo setfacl -m g:bakerstreet:rwx /shares/cases/
sudo setfacl -m g:bakerstreet:rw /shares/cases/*
sudo setfacl -dm g:bakerstreet:rw /shares/cases/
# set acl for scotlandyard (access only to 2 files without listing cases directory)
sudo setfacl -m g:scotlandyard:x /shares/
sudo setfacl -m g:scotlandyard:x /shares/cases/
sudo setfacl -m g:scotlandyard:rw /shares/cases/{murders,moriarty}.txt
sudo setfacl -m u:jones:r /shares/cases/{murders,moriarty}.txt
# to limit access except 2 files for scotlandyard we must use one of this commands:
sudo setfacl -dm g:scotlandyard:- /shares/cases/
sudo chmod -R o-rwx /shares/
