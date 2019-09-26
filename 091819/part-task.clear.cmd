#!/bin/bash
# remove from fstab
sudo sed -i '/\/dev\/sdb1/d' /etc/fstab 
sudo sed -i '/\/dev\/sdb2/d' /etc/fstab 

# umount and swapoff
sudo umount /dev/sdb1
sudo rm -d /backup
sudo swapoff /dev/sdb2

# destroy GPT
echo -e "x\nz\nY\nY\n" | sudo gdisk /dev/sdb 
