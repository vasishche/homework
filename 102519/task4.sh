#!/bin/bash
# Create file at /etc/systemd/system/docker.service.d/startup_options.conf
sudo mkdir -p /etc/systemd/system/docker.service.d/
sudo cp startup_options.conf /etc/systemd/system/docker.service.d/
sudo systemctl daemon-reload
sudo systemctl restart docker.service

# required python package: docker/docker-py
sudo pip3 install docker

