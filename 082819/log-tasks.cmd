#!/bin/bash
# 2.1
oldTZ=$( timedatectl | grep "Time zone" | awk '{print $3}' ); echo "Current TZ: $oldTZ"
newTZ=$( timedatectl list-timezones | grep "Havana" ); echo "New TZ: $newTZ"
timedatectl set-timezone $newTZ
if [[ $newTZ == $( timedatectl | grep "Time zone" | awk '{print $3}' ) ]]; then echo "TZ changed successfully. Current TZ: $newTZ."; else echo "Something went wrong"; fi
# output:
# Current TZ: Europe/Moscow
# New TZ: America/Havana
# TZ changed successfully. Current TZ: America/Havana.

# Restore old TZ
read -p "Restore previous TZ (y/n): " -n 1; if [[ $REPLY =~ ^[Yy]$ ]]; then timedatectl set-timezone $oldTZ; fi; echo 

# 2.2
journalctl -S -50m _UID=81
# a dozen of messages like:
# Sep 16 08:11:59 vm01 dbus[2737]: [system] Successfully activated service 'net.reactivated.Fprint'

# 2.3
sudo bash -c 'echo "auth,authpriv.alert /var/log/auth-errors" > /etc/rsyslog.d/auth-errors.conf'
sudo systemctl restart rsyslog.service
logger -p auth.emerg "Test message"
sleep 1
echo "File /var/log/auth-errors log messages:"; sudo cat /var/log/auth-errors
# output part:
# Sep 16 09:00:48 vm01 vasily: Test message

# cleaning
sudo rm /etc/rsyslog.d/auth-errors.conf /var/log/auth-errors
sudo systemctl restart rsyslog.service
