#!/bin/bash
set -euo pipefail

python_version="3.11.4"

pyenv install "$python_version"
pyenv global "$python_version"
pyenv rehash
eval "$(pyenv init -)"
sudo pip install --upgrade pip
