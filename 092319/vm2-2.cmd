#!/bin/bash
# 27. start datanode daemons
sudo -u hdfs bash -c "$HADOOP_HOME/bin/hdfs --daemon start datanode"
sudo -u yarn bash -c "$HADOOP_HOME/bin/yarn --daemon start nodemanager"

# 29. create systemd units 
sudo cp {hdfs,yarn}-worker.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable {hdfs,yarn}-worker
