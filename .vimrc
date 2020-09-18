set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Dockerfile syntax highlight
Plugin 'ekalinin/Dockerfile.vim'

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'

" lean & mean status/tabline for vim that's light as air
Bundle 'https://github.com/bling/vim-airline.git'

" nerdtree - A tree explorer plugin for vim.
Bundle 'https://github.com/scrooloose/nerdtree.git'

" fugitive.vim: a Git wrapper so awesome, it should be illegal
Bundle 'tpope/vim-fugitive'
" enable fugitive.vim Gbrowse for github
Bundle 'tpope/vim-rhubarb'

Bundle 'fatih/vim-go'

Bundle 'itspriddle/vim-shellcheck'

call vundle#end()

" general
set encoding=utf8
set number
syntax on
set ruler
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set showmatch
set noerrorbells novisualbell

" nerdtree
let NERDTreeShowHidden=1
let NERDTreeWinSize = 40

" powerline
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set t_Co=256
set spelllang=en
set background=dark
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
