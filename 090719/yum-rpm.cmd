#!/bin/bash
# add docker community edition repository
sudo yum-config-manager --add-repo="https://download.docker.com/linux/centos/docker-ce.repo"

# install 18.09.9 version
sudo yum -y install docker-ce-18.09.9 docker-ce-cli-18.09.9 containerd.io

# ckeck info
yum info docker-ce{,-cli}

# update
sudo yum -y update docker-ce{,-cli}

# list yum history
sudo yum history

# get info with rpm
rpm -qi docker-ce{,-cli}
