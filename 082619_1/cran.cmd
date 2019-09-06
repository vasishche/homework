#!/bin/bash
# create copy of anacrontab file
sudo cp /etc/anacrontab{,.backup}
# add anacron job
sudo bash -c "echo '2	1	ana-job	echo \"Hello from anacron\" >> /opt/hello' >> /etc/anacrontab"
# create copy of crontab file
sudo cp /etc/crontab{,.backup}
# add cron job
cp cron-job /tmp/
sudo bash -c "echo '@reboot	root	sleep 60 && /tmp/cron-job' >> /etc/crontab"
# reboot
# some time after reboot /opt/hello file will contain this two strings:
# Hello from cron
# Hello from anacron
