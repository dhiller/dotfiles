#!/bin/bash

sudo dnf install -y make docker

# allow usage w/o root
sudo groupadd docker
sudo gpasswd -a $USER docker

# enable docker daemon on system start
sudo systemctl enable docker 
sudo systemctl start docker 

# install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
sudo install kubectl /usr/local/bin 

echo "WARNING: this will terminate current gnome session! Continue? (y/N)"
read answer
if [ "$answer" != "y" ]; then
    exit 0
fi

gnome-session-quit
