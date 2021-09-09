#!/usr/bin/env bash

cd /tmp
latest_tag=$(curl -L -H'Accept: application/json' https://github.com/derailed/k9s/releases/latest | jq -r '.tag_name')
wget "https://github.com/derailed/k9s/releases/download/$latest_tag/k9s_Linux_x86_64.tar.gz"
tar zxvf k9s_Linux_x86_64.tar.gz
sudo install k9s /usr/local/bin/ 
