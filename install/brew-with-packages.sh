#!/bin/bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT="$( cd "$DIR"; cd ..; pwd )"

# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew --version
if [ "$?" -ne 0 ]; then
    echo "brew install failed?"
    exit 1
fi

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
done < "$PARENT/packages/brew_cask.txt"
