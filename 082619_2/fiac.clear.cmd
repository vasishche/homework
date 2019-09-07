#!/bin/bash 
eval "sudo userdel -r "{glen,antony,lesly}";"
sudo groupdel students
sudo rm -r /home/students /data1
