#!/bin/bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT="$( cd "$DIR"; cd ..; pwd )"

set +e
# install brew
brew --version
if [ "$?" -ne 0 ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
set -e

set +e
brew --version
if [ "$?" -ne 0 ]; then
    echo "brew install failed?"
    exit 1
fi
set -e

# install brew packages
while IFS='' read -r line || [[ -n "$line" ]]; do
    brew install "$line"
done < "$PARENT/packages/brew.txt"

# tap caskroom for OS X Applications
brew tap caskroom/cask
brew tap caskroom/versions

# install apps
while IFS='' read -r line || [[ -n "$line" ]]; do
    brew cask install "$line"
done < "$PARENT/packages/brew-cask.txt"
