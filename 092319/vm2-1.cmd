#!/bin/bash
# 17. create datanode-dir
sudo mkdir /opt/mount{1,2}/datanode-dir

# 18. change owner to hdfs:hadoop
sudo chown hdfs:hadoop /opt/mount{1,2}/datanode-dir/

# 19. create nodemanager-local-dir and nodemanager-log-dir
sudo mkdir /opt/mount{1,2}/nodemanager-{local,log}-dir

# 20. change owner to yarn:hadoop
sudo chown yarn:hadoop /opt/mount{1,2}/nodemanager-{local,log}-dir
