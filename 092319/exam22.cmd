#!/bin/bash
# 22.2 set static ip (vm1 - 97, vm2 - 98), auto UP host-only connection and restart NM
nmcli c modify enp0s8 autoconnect yes
# nmcli c m enp0s8 connection.zone trusted # resets after reboot ! bug firewalld#195 CentOs 7
sudo sed -i.backup 's/BOOTPROTO=dhcp/BOOTPROTO=static/g' /etc/sysconfig/network-scripts/ifcfg-enp0s8
if [[ $( ip a | grep link/ether | awk '{print $2}' ) == $( cat /tmp/exam/vmac ) ]]; then
	sudo bash -c "echo 'IPADDR=192.168.56.97' >> /etc/sysconfig/network-scripts/ifcfg-enp0s8"
else
	sudo bash -c "echo 'IPADDR=192.168.56.98' >> /etc/sysconfig/network-scripts/ifcfg-enp0s8"
	hostnamectl set-hostname vm2
fi
sudo systemctl restart NetworkManager
nmcli c up enp0s8

# disable service
sudo systemctl disable exam22
