#!/bin/bash
set -ex

# customize linux terminal (zsh, oh-my-zsh, vim, tmux etc)
# see:
# * https://maxim-danilov.github.io/make-linux-terminal-great-again/
# * https://fedoramagazine.org/add-power-terminal-powerline/

# install rpmfusion repositories
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# install brave browser and set as default

sudo dnf install -y dnf-plugins-core
#sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
#sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
#sudo dnf install -y brave-browser
#xdg-settings set default-web-browser brave-browser.desktop
curl -fsS https://dl.brave.com/install.sh | sh

# install required packages for powerline to look great in vim and tmux
sudo dnf install -y \
    zsh \
    util-linux-user \
    redhat-display-fonts \
    redhat-text-fonts \
    vim \
    powerline \
    powerline-fonts \
    tmux-powerline \
    vim-powerline

# install other stuff
sudo dnf install -y \
    jq \
    ShellCheck \
    openssh-askpass

# install yubikey cli
sudo dnf install yubikey-manager -y

./install/linux-yq.sh

# install https://github.com/homeport/dyff
curl --silent --location https://git.io/JYfAY | bash

# install devices

# logitech unifying receiver device manager
# see https://apps.fedoraproject.org/packages/solaar
sudo dnf install -y solaar

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install powerlevel10k
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/themes/powerlevel10k

# install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install bundles for vim
vim +PluginInstall +qall

# install other tools
sudo dnf install -y \
    asciinema \
    cowsay \
    direnv \
    fortune-mod \
    fzf \
    lolcat \
    xsel # required for oh-my-tmux copy to clipboard mode

# clone required repositories
[ ! -d "$HOME/Projects/github.com/dhiller" ] && mkdir -p "$HOME/Projects/github.com/dhiller"
cd "$HOME/Projects/github.com/dhiller"
git clone git@github.com:dhiller/utility-scripts.git
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git

# set zsh as default shell
chsh -s $(which zsh)

cat <<EOF
# TODO
#
# install Meslo Nerd Font
# see https://github.com/romkatv/powerlevel10k#recommended-meslo-nerd-font-patched-for-powerlevel10k
#
# install gogh terminal theme
# https://gogh-co.github.io/Gogh/
# Theme: Dimmed Monokai
EOF
