#!/bin/bash
sudo yum install --downloadonly --downloaddir=exam-repo/ java-1.8.0-openjdk yum-utils git
sudo yum install -y createrepo
createrepo --database exam-repo
