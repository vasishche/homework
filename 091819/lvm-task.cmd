#!/bin/bash
# 2.1 new 2GB (8e00 - Linux LVM)
echo -e "n\n3\n2561M\n+2G\n8e00\np\nw\nY\n" | sudo gdisk /dev/sdb

# 2.2 new PV 
sudo pvcreate -f /dev/sdb3

# 2.3 extend centos vg
sudo vgextend centos /dev/sdb3

# 2.4 extend LV by 1GB
sudo lvextend -L +1G centos/root /dev/sdb3

# 2.5 check root disk space usage
df -h | grep centos-root
#/dev/mapper/centos-root  6.2G  5.3G  924M  86% /

# 2.6 extend fs !!!
# this step can't be simply undone due to XFS can't be directly reduced
# the initial state of the VM can be easily restored from the backup
sudo xfs_growfs /dev/mapper/centos-root

# 2.7 reboot and verify
# reboot
# df -h | grep centos-root
# /dev/mapper/centos-root  7.2G  5.3G  2.0G  74% /
