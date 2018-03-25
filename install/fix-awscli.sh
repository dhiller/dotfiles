#!/bin/bash
set -euo pipefail

# install awscli endpoint to fix aws using brew python version
/usr/local/opt/awscli/libexec/bin/pip install awscli-plugin-endpoint
aws --version
