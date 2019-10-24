#!/bin/bash

sudo dnf install -y make docker

# allow usage w/o root
sudo groupadd docker
sudo gpasswd -a $USER docker

# enable docker daemon on system start
sudo systemctl enable docker 
sudo systemctl start docker 

echo "WARNING: this will terminate current gnome session! Continue? (y/N)"
read answer
if [ "$answer" != "y" ]; then
    exit 0
fi

gnome-session-quit
