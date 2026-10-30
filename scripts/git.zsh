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
