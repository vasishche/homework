#!/bin/bash
# 15. create namenode-dir
sudo mkdir /opt/mount{1,2}/namenode-dir

# 16. change owner to hdfs:hadoop
sudo chown hdfs:hadoop /opt/mount{1,2}/namenode-dir
