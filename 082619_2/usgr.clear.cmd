#!/bin/bash 
eval "sudo userdel -r "{bob,alice,eve}";"
sudo groupdel sales
sudo mv /etc/login.defs{.backupfile,}
