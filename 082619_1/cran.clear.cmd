#!/bin/bash
sudo sed -i '/@reboot	root	sleep 60 \&\& \/tmp\/cron-job/d' /etc/crontab
sudo sed -i '/2	1	ana-job	echo \"Hello from anacron\" >> \/opt\/hello/d' /etc/anacrontab
sudo rm /tmp/cron-job /opt/hello
echo "Attention! Remove crontab.backup and anacrontab.backup manually if originals are OK!"
