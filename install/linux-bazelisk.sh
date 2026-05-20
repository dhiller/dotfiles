#!/usr/bin/env bash

set -x
set -e
set -u
set -o pipefail

BAZELISK_VERSION="${BAZELISK_VERSION:-v1.27.0}"
BAZELISK_BINARY=bazelisk-linux-amd64
wget "https://github.com/bazelbuild/bazelisk/releases/download/${BAZELISK_VERSION}/${BAZELISK_BINARY}"
sudo install "${BAZELISK_BINARY}" /usr/local/bin/bazel

