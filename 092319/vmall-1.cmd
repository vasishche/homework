#!/bin/bash
# 2. I made "exam" user an administrator during install, otherwise: 
su -c "usermod -aG wheel exam"
# add NOPASSWD:
sudo bash -c "echo 'exam	ALL=(ALL)	NOPASSWD: ALL' > /etc/sudoers.d/exam"

# 3. install OpenJDK8
sudo yum -y install java-1.8.0-openjdk

# 4. download hadoop
if ! [[ -d /tmp/exam/ ]]; then mkdir /tmp/exam; curl https://archive.apache.org/dist/hadoop/common/hadoop-3.1.2/hadoop-3.1.2.tar.gz -o '/tmp/exam/hadoop.tar.gz'; fi

# 5. extract the archive
sudo tar -zxf /tmp/exam/hadoop.tar.gz -C /opt/

# 6. make a symlink
sudo mkdir /usr/local/hadoop
sudo ln -s /opt/hadoop-3.1.2/ /usr/local/hadoop/current

# 7. add new group and users
sudo groupadd hadoop
eval "sudo useradd -g hadoop -N "{hadoop,yarn,hdfs}";"

# create logs directory, +w for hadoop group
sudo mkdir /usr/local/hadoop/current/logs
sudo chown -R hadoop:hadoop /usr/local/hadoop/current/
sudo chmod g+w /usr/localhadoop/current/logs

# 8. create new partitions
echo -e "n\n\n\n\n\nt\n8e\np\nw\n" | sudo fdisk /dev/sdb
echo -e "n\n\n\n\n\nt\n8e\np\nw\n" | sudo fdisk /dev/sdc

# 9. PV inititalization 
sudo pvcreate -f /dev/sdb1
sudo pvcreate -f /dev/sdc1

# 10. VG creating 
sudo vgcreate hdfs1 /dev/sdb1
sudo vgcreate hdfs2 /dev/sdc1

# 11. LV creating
sudo lvcreate -l 100%VG -n lvol0 hdfs1
sudo lvcreate -l 100%VG -n lvol0 hdfs2

# 12. FS creating
sudo mkfs.ext4 /dev/mapper/hdfs1-lvol0 
sudo mkfs.ext4 /dev/mapper/hdfs2-lvol0 

# 13. mount points creating
sudo mkdir /opt/mount{1,2}

# 14. mounting new fs
sudo bash -c 'echo -e "/dev/mapper/hdfs1-lvol0\t/opt/mount1\text4\tdefaults\t0\t0" >> /etc/fstab'
sudo bash -c 'echo -e "/dev/mapper/hdfs2-lvol0\t/opt/mount2\text4\tdefaults\t0\t0" >> /etc/fstab'
sudo mount -a

# 21. hadoop ssh config
sudo -u hadoop bash -c "ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa"
sudo -u hadoop bash -c "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys"
sudo -u hadoop bash -c "chmod 0600 ~/.ssh/authorized_keys"
# exam ssh config
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

# 22.1 add hosts and add service to auto assign static IPs after VM clone
echo -e "192.168.56.97\tvm1-headnode\n192.168.56.98\tvm2-worker" | sudo tee -a /etc/hosts
ip a | grep link/ether | awk '{print $2}' > /tmp/exam/vmac
sudo cp exam22.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable exam22

# 23.
# install git
sudo yum -y install git

# download config files
mkdir /tmp/exam/{tmp,conf}
cd /tmp/exam/tmp
eval 'git clone $(head -'{1..4}' ../gist | tail -1);'
cp */*.xml */*.sh ../conf
cd -
rm -rf /tmp/exam/tmp

# edit and copy config files
sed -i -r "s,^(export JAVA_HOME=).*,\1\"$(dirname $(dirname $(readlink -f $(which java))))\",g;s,^(export HADOOP_HOME=).*,\1\"/usr/local/hadoop/current\",g;s/^(export HADOOP_HEAPSIZE_MAX=).*/\1\"512M\"/g" /tmp/exam/conf/hadoop-env.sh
sed -i -r 's/^(.*)%HDFS_NAMENODE_HOSTNAME%(.*)/\1vm1-headnode\2/g' /tmp/exam/conf/core-site.xml
sed -i -r 's#^(.*)%NAMENODE_DIRS%(.*)#\1/opt/mount1/namenode-dir,/opt/mount2/namenode-dir\2#g;s#^(.*)%DATANODE_DIRS%(.*)#\1/opt/mount1/datanode-dir,/opt/mount2/datanode-dir\2#g' /tmp/exam/conf/hdfs-site.xml
sed -i -r 's/^(.*)%YARN_RESOURCE_MANAGER_HOSTNAME%(.*)/\1vm1-headnode\2/g;s#^(.*)%NODE_MANAGER_LOCAL_DIR%(.*)#\1/opt/mount1/nodemanager-local-dir,/opt/mount2/nodemanager-local-dir\2#g;s#^(.*)%NODE_MANAGER_LOG_DIR%(.*)#\1/opt/mount1/nodemanager-log-dir,/opt/mount2/nodemanager-log-dir\2#g' /tmp/exam/conf/yarn-site.xml
sudo cp /tmp/exam/conf/{hadoop-env.sh,{core,hdfs,yarn}-site.xml} /usr/local/hadoop/current/etc/hadoop/

# 24. create hadoop.sh in /etc/profile.d/ and reload profile
echo 'export HADOOP_HOME="/usr/local/hadoop/current"' | sudo tee -a /etc/profile.d/hadoop.sh
source /etc/profile
