#!/bin/bash

# customize linux terminal (zsh, oh-my-zsh, vim, tmux etc)
# see:
# * https://maxim-danilov.github.io/make-linux-terminal-great-again/
# * https://fedoramagazine.org/add-power-terminal-powerline/

# install required packages for powerline to look great in vim and tmux
sudo dnf install -y zsh chsh redhat-display-fonts redhat-text-fonts vim powerline powerline-fonts tmux-powerline vim-powerline

# oh-my-zsh
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# install bundles for vim
vim +PluginInstall +qall

# set zsh as default shell
chsh -s $(which zsh) 

cat <<EOF
# TODO
#
# install Meslo Nerd Font
# see https://github.com/romkatv/powerlevel10k#recommended-meslo-nerd-font-patched-for-powerlevel10k
#
# install gogh terminal theme
# https://mayccoll.github.io/Gogh/
# Theme: Dimmed Monokai

EOF
