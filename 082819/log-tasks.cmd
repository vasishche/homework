#!/bin/bash
# 2.1
oldTZ=$( timedatectl | grep "Time zone" | awk '{print $3}' ); echo "Current TZ: $oldTZ"
newTZ=$( timedatectl list-timezones | grep "Havana" ); echo "New TZ: $newTZ"
timedatectl set-timezone $newTZ
if [[ $newTZ == $( timedatectl | grep "Time zone" | awk '{print $3}' ) ]]; then echo "TZ changed successfully. Current TZ: $newTZ."; else echo "Something went wrong"; fi

# Restore old TZ
read -p "Restore previous TZ (y/n): " -n 1; if [[ $REPLY =~ ^[Yy]$ ]]; then timedatectl set-timezone $oldTZ; fi; echo 

# 2.2
journalctl -S -50m _UID=81

# 2.3
sudo bash -c 'echo "auth,authpriv.alert /var/log/auth-errors" > /etc/rsyslog.d/auth-errors.conf'
sudo systemctl restart rsyslog.service
logger -p auth.emerg "Test message"
sleep 1
echo "File /var/log/auth-errors log messages:"; sudo cat /var/log/auth-errors
# cleaning
sudo rm /etc/rsyslog.d/auth-errors.conf /var/log/auth-errors
sudo systemctl restart rsyslog.service
