#!/bin/bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# xcode tools
xcode-select --install

bash "$DIR/brew-with-packages.sh"
bash "$DIR/atom-packages.sh"
bash "$DIR/symlinks.sh"
bash "$DIR/pyenv.sh"

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# set zsh as default shell
chsh -s /bin/zsh
