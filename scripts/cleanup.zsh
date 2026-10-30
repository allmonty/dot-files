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

