# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bira"

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
plugins=(git ssh-agent docker terraform ruby python pip dnf)

source $ZSH/oh-my-zsh.sh

# User configuration

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

# open aliases
alias open_idea="open -a /Applications/IntelliJ\ IDEA/ ${@:-.}"
alias open_atom="open -a /Applications/Atom.app ${@:-.}"
alias open_chrome="open -a /Applications/Google\ Chrome.app/ ${@:-.}"

# yed alias
alias yed="(java -jar /Applications/yed/yed.jar)&"

alias vi="vim"

### Exports ###
export GROOVY_HOME=/usr/local/opt/groovy/libexec

# set brew binaries ahead of normal ones
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# kafka path addition
export PATH="$PATH:$HOME/kafka/bin"

# aws eb cli
#export LOCAL_PATH="$HOME/Library/Python/2.7/bin"
export PATH="$LOCAL_PATH:$PATH"

# work dir shortcuts

export PROJECTS="$HOME/Projects"
export GH="$PROJECTS/github.com"
export GHDH="$GH/dhiller"
export BB="$PROJECTS/bitbucket.org"
export BBDH="$BB/dhiller"
export GHE="$PROJECTS/github.intuit.com"
export GHEDH="$GHE/dhiller"
export DRAGONSTONE="$GHE/dragonstone/"
export ML="$GHE/ml/"

# added by travis gem
[ -f /Users/dhiller/.travis/travis.sh ] && source /Users/dhiller/.travis/travis.sh

# gettext (brew)
#export PATH="/usr/local/opt/gettext/bin:$PATH"

[ -f $GHDH/utility-scripts/misc/add_dirs_to_path.sh ] && CWD=$(pwd); cd $GHDH/utility-scripts; export PATH="$PATH:$(bash $GHDH/utility-scripts/misc/add_dirs_to_path.sh)"; cd $CWD

# Anaconda
#export PATH=/Users/dhiller/anaconda2/bin:$PATH

# Spark from path (downloaded binary)
#export PATH=$PATH:$HOME/bin/spark-2.1.1-bin-hadoop2.7/bin
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# python environment management
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# start tmux if necessary
tmux list-sessions > /dev/null
[ "$?" -ne 0 ] && tmux

ANDROID_HOME=/opt/android-sdk-tools-darwin-3859397


### AWS

# aws cli settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export AWS_REGION=eu-central-1
export AWS_DEFAULT_REGION=eu-central-1
#export AWS_PROFILE=default
export AWS_DEFAULT_OUTPUT="json"

# aws aliases
alias get_aws_account_id="aws sts get-caller-identity --query Account --output text"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/Cellar/terraform/0.11.3/bin/terraform terraform


### Go development
export GOPATH="${HOME}/go"
# GOROOT must only be set if installed in a custom location
# https://stackoverflow.com/a/10847122/16193
#export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"


### docker
#export DOCKER_PREFIX=index.docker.io/dhiller/kubevirt
#export DOCKER_TAG=kubevirt

# login to docker hub
function docker_login {
	echo $DOCKER_PASSWORD | docker login -u dhiller --password-stdin
}


# kubevirt
export KUBEVIRT_PROVIDER=k8s-1.13.3

# include private configuration if present
[ -f "$HOME/.zshrc_private" ] && source "$HOME/.zshrc_private"
