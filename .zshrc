# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions colorize asdf)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# === My configs

# recommended way to set Homebrew environment variables
eval "$(/opt/homebrew/bin/brew shellenv)"

# To fix the "Could not find a Flutter SDK" error
# export FLUTTER_ROOT="$(asdf where flutter)"

# === Flutter ===

export FLUTTER_ROOT="$(asdf where flutter)"

# === GIT ===

alias gitlog="git log --all --graph --decorate --oneline"

function gitclean {
  # Update branches main, staging and development if they exist

  git fetch --all --prune
 
  if git show-ref --quiet refs/heads/main; then
    echo "Updating main branch..."
    git checkout main
    git pull
  fi
  if git show-ref --quiet refs/heads/staging; then
    echo "Updating staging branch..."
    git checkout staging
    git pull
  fi
  if git show-ref --quiet refs/heads/development; then
    echo "Updating development branch..."
    git checkout development
    git pull
  fi
  # TODO: verify if this is still necessary
  # then will delete all local branches that aren't in remote
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

# === Copy videos metafiles ===

# Usefull script to copy metadata from a file to other
# The function can be used to fix converted videos using handbreak that don't keep the metadata from the original
# original source: https://www.reddit.com/r/handbrake/comments/8bm1wg/retain_creation_date_metadata_on_converted_file/

# Required program to keep/edit exif data , GPS location etc:
# brew install exiftool

# Must be executed in the folder with the .avi and .mp4 files, both original and new mus have the same filename

function copyVideosMeta {
   for f in *.avi; do
      export originalfile=$(echo ${f} | sed 's/\.avi//g')

      echo
      echo $originalfile

      # copy metadata from mov file to mp4 file
      exiftool -TagsFromFile $originalfile.avi -all:all $originalfile.mp4 
      exiftool -TagsFromFile $originalfile.avi "-AllDates<DateTimeOriginal" "-FileCreateDate<DateTimeOriginal" "-FileModifyDate<DateTimeOriginal" $originalfile.mp4
      # force the copy of the created and modified at for videos
      # alternative 1
      # exiftool -d "%Y:%m:%d %H:%M:%S" -TagsFromFile $originalfile.avi "-QuickTime:CreateDate<FileModifyDate" "-QuickTime:CreationDate<FileModifyDate" "-FileCreateDate<FileModifyDate" "-FileModifyDate<FileModifyDate" -api QuickTimeUTC $originalfile.mp4
      # alternative 2
      # exiftool -TagsFromFile $originalfile.avi -GlobalTimeShift +3 "-QuickTime:CreateDate<FileModifyDate" -TagsFromFile $originalfile.avi -d "%Y:%m:%d %H:%M:%S-03:00" "-QuickTime:CreationDate<FileModifyDate" "-FileCreateDate<FileModifyDate" "-FileModifyDate<FileModifyDate" -overwrite_original $originalfile.mp4
      # alternative 3
      exiftool -TagsFromFile $originalfile.avi -d "%Y:%m:%d %H:%M:%S-03:00" "-QuickTime:CreateDate<FileModifyDate" "-QuickTime:CreationDate<FileModifyDate" "-FileCreateDate<FileModifyDate" "-FileModifyDate<FileModifyDate" -overwrite_original $originalfile.mp4
      # alternative 4
      exiftool -TagsFromFile $originalfile.avi "-QuickTime:CreationDate<FileModifyDate" "-FileCreateDate<FileModifyDate" "-FileModifyDate<FileModifyDate" -GlobalTimeShift +3 "-QuickTime:CreateDate<FileModifyDate" -overwrite_original $originalfile.mp4
      # copy creation date from mov file to mp4 file
      # touch -r $originalfile.avi $originalfile.mp4

      # optional (remove comment) remove original file and backup from exiftool
      # rm $originalfile.mov $originalfile.mp4_original
   done
}

# === End of my configs

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/allmonty/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# Added by Antigravity
export PATH="/Users/allmonty/.antigravity/antigravity/bin:$PATH"

# Added by Antigravity CLI installer
export PATH="/Users/allmonty/.local/bin:$PATH"

# Added by Antigravity IDE
export PATH="/Users/allmonty/.antigravity-ide/antigravity-ide/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/allmonty/.lmstudio/bin"
# End of LM Studio CLI section

# Claude code configs
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=true
# End of Claude code configs

# === Cleanup (run from ~/Dev) ===
# Each _clean_* handles ONE project folder and skips it if it's not that type.
# _each_project runs one over every folder up to 2 levels deep.

_each_project() {
  local dir
  for dir in */(N/) */*/(N/); do
    "$1" "$dir"
  done
}

_clean_flutter() {
  [[ -f "$1/pubspec.yaml" ]] && grep -q 'sdk: *flutter' "$1/pubspec.yaml" || return 0
  echo "🧹 flutter: $1"
  (cd "$1" && flutter clean)
}

# node_modules comes back with `npm install`; nested workspaces (3+ levels deep) are not found
_clean_node() {
  [[ -f "$1/package.json" && -d "$1/node_modules" ]] || return 0
  echo "🧹 node: $1"
  rm -rf "$1/node_modules"
}

_clean_gradle() {
  [[ -f "$1/gradlew" ]] || return 0
  # Flutter android/ folders: flutter clean already covers them, and gradle needs pub get first
  [[ -f "$1/../pubspec.yaml" ]] && return 0
  echo "🧹 gradle: $1"
  # Gradle 8.x cannot run on Java 25, so use Android Studio bundled Java 21
  (cd "$1" && JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home" sh ./gradlew clean --no-daemon)
}

_clean_git() {
  [[ -e "$1/.git" ]] || return 0
  # a lock file means a git command is running there; pruning now could corrupt it
  if [[ -e "$1/.git/index.lock" ]]; then
    echo "⏭️  git: $1 (git is busy, skipped)"
    return 0
  fi
  echo "🧹 git: $1"
  git -C "$1" gc --prune=now --quiet
}

flutter_clean_all() { _each_project _clean_flutter }
node_clean_all()    { _each_project _clean_node }
gradle_clean_all()  { _each_project _clean_gradle }
git_prune_all()     { _each_project _clean_git }

# Run every cleaner; git last so it packs what the others left
clean_all() {
  flutter_clean_all
  node_clean_all
  gradle_clean_all
  git_prune_all
}

# === end of cleanup ===

sizes() {
  du -sh *(D/) | sort -h

  du -sh .
}

