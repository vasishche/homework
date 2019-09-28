#!/bin/bash
# 22.vm1 set static ip, restart NM and UP host-only connection
sudo sed -i.backup 's/BOOTPROTO=dhcp/BOOTPROTO=static/g' /etc/sysconfig/network-scripts/ifcfg-enp0s8
sudo bash -c "echo 'IPADDR=192.168.56.97' >> /etc/sysconfig/network-scripts/ifcfg-enp0s8"
sudo systemctl restart NetworkManager
nmcli c up enp0s8
