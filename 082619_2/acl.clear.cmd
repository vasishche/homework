#!/bin/bash 
eval "sudo userdel -r "{holmes,watson,lestrade,gregson,jones}" 2>/dev/null;"
eval "sudo groupdel "{bakerstreet,scotlandyard}";"
sudo rm -r /shares/
rm user.pass
