#!/bin/bash
# 25. namenode HDFS format
sudo -u hdfs bash -c "$HADOOP_HOME/bin/hdfs namenode -format cluster1"

# 26. start namenode daemons
sudo -u hdfs bash -c "$HADOOP_HOME/bin/hdfs --daemon start namenode"
sudo -u yarn bash -c "$HADOOP_HOME/bin/yarn --daemon start resourcemanager"

# 28. config firewall for hadoop web-UIs
# sudo firewall-cmd --permanent --add-port=9870/tcp
# sudo firewall-cmd --permanent --add-port=8088/tcp
# sudo firewall-cmd --reload

# 29. create systemd units
sudo cp /tmp/exam/{hdfs,yarn}-headnode.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable {hdfs,yarn}-headnode
