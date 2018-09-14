# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/allan/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "norm" "risto" "jnrowe" "agnoster" )

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
ENABLE_CORRECTION="false"

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
plugins=(
  git
  git-open
)

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
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/allan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#=======My configurations=======#

#Python asdf

# export PATH=$PATH:/home/allan/.asdf/installs/python/3.6.5/bin

#GIT

alias gitlog="git log --all --graph --decorate --oneline"
alias gitclean="git checkout master ; git pull ; git fetch -ap ; delete_branches_not_in_remote"

function delete_branches_not_in_remote {
  BRANCH=$1
  
  # creates array with local branches as LOCALS
  LOCALS=`git branch | cut -c 3- | tr '\n' ':'`
  LOCALS=("${(@s/:/)LOCALS}")

  # creates array with remote branches as REMOTES
  REMOTES=`git branch --remote | cut -c 10- | tr '\n' ':'`
  REMOTES=("${(@s/:/)REMOTES}")
  
  for local in $LOCALS; do
    is_in_remote=0
    for remote in $REMOTES; do
      if [ $local = $remote ]; then
        is_in_remote=1
      fi
    done
    if [ $is_in_remote = 0 ]; then
      git branch -D $local
    fi
  done
}

#Version manager: asdf

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

#Zsh autosuggest

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

#GIT pair programming

function solo {
  unset GIT_COMMITTER_NAME
  unset GIT_COMMITTER_EMAIL
  echo "Unsetting pair."
}

function pair_with_ {
  export GIT_COMMITTER_NAME=$1
  export GIT_COMMITTER_EMAIL=$2
  echo "Setting"  $1  "as pair."
}

function pair_with_miguel {
    pair_with_ "Miguel Péres" "foxmpc@gmail.com"
}

function pair_with_victor {
    pair_with_ "Victor Peres" "victor.peres93@gmail.com"
}

function pair_with_vitor {
    pair_with_ "Vitor Trindade" "emailreservadovitor@gmail.com"
}

function pair_with_raissa {
    pair_with_ "Raissa Ferreira" "rai200890@gmail.com"
}
