#!/bin/bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT="$( cd "$DIR"; cd ..; pwd )"

brew list > "$PARENT/packages/brew.txt"
brew cask list > "$PARENT/packages/brew-cask.txt"
