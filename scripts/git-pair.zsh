# === GIT pair programming ===

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
