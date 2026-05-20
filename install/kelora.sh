#!/usr/bin/env bash

set -euo pipefail
set -x

release='v0.10.0'
if [ $# =gt 0 ]; then
    release="$1"
fi

(
    cd "$(mktemp -d)" || exit 1
    tmpdir=$(pwd)
    trap 'rm -rf '"$tmpdir" EXIT SIGINT SIGTERM

    wget "https://github.com/dloss/kelora/releases/download/${release}/kelora-x86_64-unknown-linux-musl.tar.gz"
    ls -al
    tar -zxvf kelora-x86_64-unknown-linux-musl.tar.gz
    chmod +x kelora
    sudo install kelora /usr/local/bin
)