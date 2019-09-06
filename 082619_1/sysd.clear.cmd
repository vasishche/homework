#!/bin/bash  
sudo rm /{tmp,etc/systemd/system}/{one,two}-daemon* /tmp/homework
sudo systemctl daemon-reload
