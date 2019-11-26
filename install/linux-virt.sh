#!/bin/bash

sudo dnf install -y make docker kubernetes-client fuse-sshfs

# allow usage w/o root
sudo groupadd docker
sudo gpasswd -a $USER docker

# enable docker daemon on system start
sudo systemctl enable docker 
sudo systemctl start docker 

(
  set -x; cd "$(mktemp -d)" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/download/v0.3.1/krew.{tar.gz,yaml}" &&
  tar zxvf krew.tar.gz &&
  ./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" install \
    --manifest=krew.yaml --archive=krew.tar.gz
)

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

echo "WARNING: this will terminate current gnome session! Continue? (y/N)"
read answer
if [ "$answer" != "y" ]; then
    exit 0
fi

gnome-session-quit
