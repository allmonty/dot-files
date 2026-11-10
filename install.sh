#!/bin/sh
# Symlink ~/.zshrc to this repo's .zshrc. Safe to run again.
set -e

repo_zshrc="$(cd "$(dirname "$0")" && pwd)/.zshrc"
target="$HOME/.zshrc"

if [ -L "$target" ] && [ "$(readlink "$target")" = "$repo_zshrc" ]; then
  echo "already linked: $target -> $repo_zshrc"
  exit 0
fi

if [ -e "$target" ] || [ -L "$target" ]; then
  backup="$target.bak.$(date +%Y%m%d%H%M%S)"
  mv "$target" "$backup"
  echo "backed up old file to $backup"
fi

ln -s "$repo_zshrc" "$target"
echo "linked: $target -> $repo_zshrc"

# A script can't source into the shell that ran it, so start a fresh zsh that loads the new file
if [ -t 0 ]; then exec zsh; fi
