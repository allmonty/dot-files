# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/allandavid/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting asdf)

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"



#===============================#
#====== My configurations ======#
#===============================#

# set default editor for terminal programs
export VISUAL=vim
export EDITOR="$VISUAL"

#=== ASDF ===

# In case we remove asdf from plugins we must load asdf.sh
# . "$HOME/.asdf/asdf.sh"

#=== GIT ===

alias gitlog="git log --all --graph --decorate --oneline"

function gitclean {
  # Will checkout to master, pull, fetch all and prune
  # then will delete all local branches that aren't in remote

  git checkout master
  git pull
  git fetch -ap

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

function commit_wip {
  # Will create a wip commit with a random The Simpsons quote
  # ------ You must install jq (https://stedolan.github.io/jq/)
  DATA=`curl -s "https://thesimpsonsquoteapi.glitch.me/quotes\?count\=1"`
  QUOTE=`echo $DATA | jq -r '.[0]["quote"]'`
  IMAGE=`echo $DATA | jq -r '.[0]["image"]'`
  git add -A
  git commit -m "WIP: $QUOTE" -m "$IMAGE"
  git push
}

function gitupdateall {
  for f in */ ; do
    print "\nGitclean at $f\n"
    $(cd $f && gitclean)
  done
}

function alarm {
  sleep `expr $1 \* 60` && afplay ~/Music/submarine.mp3
}

### mac only?
function alarm2 {
  sleep `expr $1 \* 60`
  for j in {1..5}
  do
    say -v luciana $2
    sleep 1
  done
}

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
