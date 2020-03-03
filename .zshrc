[ "$(hostname)" = 'dhiller-fedora-work' ] && . /usr/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ssh-agent docker terraform ruby python pip dnf vundle tmux)

source $ZSH/oh-my-zsh.sh

# User configuration

export TERMINAL='gnome-terminal'

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias vi="vim"
alias yamllint="yamllint -d relaxed"

# work dir shortcuts

export PROJECTS="$HOME/Projects"
export GH="$PROJECTS/github.com"
export GHDH="$GH/dhiller"
export BB="$PROJECTS/bitbucket.org"
export BBDH="$BB/dhiller"

[ -f $GHDH/utility-scripts/misc/add_dirs_to_path.sh ] && CWD=$(pwd); cd $GHDH/utility-scripts; export PATH="$PATH:$(bash $GHDH/utility-scripts/misc/add_dirs_to_path.sh)"; cd $CWD

# start tmux if necessary
# tmux list-sessions > /dev/null
# [ "$?" -ne 0 ] && tmux || tmux attach-session

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ "$(hostname)" = 'dhiller-fedora-work' ] && source /home/dhiller/Projects/github.com/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


### kubevirt prow

alias oc_get_prow_jobs='oc get pods -L ''prow.k8s.io/job'' -L ''prow.k8s.io/refs.pull'''
function oc_get_prow_jobs_for_pr {
    if [ "$#" -eq 0 ] || [[ ! "$1" =~ ^[0-9]+$ ]]; then
        echo "PR number required"
        return 1
    fi
    oc_get_prow_jobs -l 'prow.k8s.io/refs.pull='"$@"
}

### disk usage
function showgigs {
    if [ "$#" -eq 0 ]; then
        echo "usage: showgigs file1..."
        return 1
    fi
    du -h --max-depth=1 "$@" | grep -E '^[0-9\.]+G'
}

### docker

# login to docker hub
function docker_login {
    docker login -u dhiller --password $DOCKER_PASSWORD
}

# login to openshift ci image registry (only when already logged in)
function docker_openshift_login {
    echo $(oc whoami -t) | docker login registry.svc.ci.openshift.org --username $USER --password-stdin
}

### go ###

# gimme
export GIMME_GO_VERSION="1.12.8"
eval $(gimme)
export PATH="$PATH:$HOME/go/bin"

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# add bin dir to path
[ -d "$HOME/bin" ] && export PATH="$PATH:$HOME/bin"

# add gradle to path
export PATH="$PATH:/opt/gradle/gradle-5.6.4/bin"

# include private configuration if present
[ -f "$HOME/.zshrc_private" ] && source "$HOME/.zshrc_private"

# pyenv
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
fi
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

[ -d "$HOME/bin/gsutil" ] && export PATH="$PATH:$HOME/bin/gsutil"

[ "$(hostname)" = 'dhiller-fedora-work' ] && fortune-by-random-char ~/cows/unsubsquirrel.cow
