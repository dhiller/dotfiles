#!/usr/bin/env bash

set -x
set -e
set -u
set -o pipefail

YQ_VERSION=v4.47.2; YQ_BINARY=yq_linux_amd64; wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY}.tar.gz -O - |\
  tar xz && sudo install ${YQ_BINARY} /usr/local/bin/yq