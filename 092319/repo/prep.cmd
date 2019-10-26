#!/bin/bash
# create exam-repo repository with most required packages
sudo cp exam-repo.repo /etc/yum.repos.d/

# enable local repo and disable remote repos
sudo yum -y --disablerepo=* --enablerepo=exam-repo install yum-utils
sudo yum-config-manager --disable \* >/dev/null
sudo yum-config-manager --enable exam-repo >/dev/null
yum repolist
