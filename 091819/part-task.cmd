#!/bin/bash
# 1.1 & 1.2 new 2GB (8300 - Linux filesystem), new 512MB (8200 - Linux SWAP), print and write
echo -e "n\n\n\n+2G\n8300\nn\n\n\n+512M\n8200\np\nw\nY\n" | sudo gdisk /dev/sdb 

# 1.3 format with XFS
sudo mkfs.xfs -f /dev/sdb1

# 1.4 make SWAP
sudo mkswap /dev/sdb2
# enable new SWAP
sudo swapon /dev/sdb2

# 1.5 add sdb1 to fstab
sudo mkdir /backup
sudo bash -c 'echo -e "/dev/sdb1\t/backup\txfs\tdefaults\t0\t0" >> /etc/fstab'
# check
sudo umount /dev/sdb1 2>/dev/null
sudo mount -a

# 1.6 add sdb2 to fstab
sudo bash -c 'echo -e "/dev/sdb2\tswap\tswap\tdefaults\t0\t0" >> /etc/fstab'
# check
sudo swapoff /dev/sdb2
sudo swapon -a

# 1.7 reboot and verify
reboot

# after reboot we can verify if sdb1 mounted
# mount | grep sdb1
# /dev/sdb1 on /backup type xfs (rw,relatime,seclabel,attr2,inode64,noquota)

# and check swap summary
# swapon -s
# Filename				Type		Size	Used	Priority
# /dev/dm-1                              	partition	839676	43960	-2
# /dev/sdb2                              	partition	524284	0	-3

# ram and swap
# free -h
#               total        used        free      shared  buff/cache   available
# Mem:           991M        658M         76M         29M        256M        103M
# Swap:          1.3G         42M        1.3G
