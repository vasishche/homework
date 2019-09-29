#!/bin/bash
# 22.2 set static ip (vm1 - 97, vm2 - 98), auto UP host-only connection and restart NM
sudo sed -i.backup 's/BOOTPROTO=dhcp/BOOTPROTO=static/g' /etc/sysconfig/network-scripts/ifcfg-enp0s8
if [[ $( ip a | grep link/ether | awk '{print $2}' ) == $( cat /tmp/exam/vm1mac ) ]]; then
	sudo bash -c "echo 'IPADDR=192.168.56.97' >> /etc/sysconfig/network-scripts/ifcfg-enp0s8"
else
	sudo bash -c "echo 'IPADDR=192.168.56.98' >> /etc/sysconfig/network-scripts/ifcfg-enp0s8"
	hostnamectl set-hostname vm2
fi
nmcli c modify enp0s8 autoconnect yes
sudo systemctl restart NetworkManager

# disable service
sudo systemctl disable exam22
