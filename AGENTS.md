# AGENTS.md

Personal dotfiles repo (macOS, zsh). There is no build, test or lint tooling.

## Layout

- `.zshrc`: config only (Oh My Zsh, PATH, env, tool init blocks). It sources every `scripts/*.zsh` through the fixed path `$HOME/Dev/dot-files/scripts`.
- `scripts/*.zsh`: shell functions and aliases, one file per topic (git, git-pair, alarm, videos, cleanup). Put new functions here, not in `.zshrc`.
- `git/`, `vscode/`, `clojure/`, `Thinkpad/`: configs and reference notes, independent of each other.
- `ubuntu/ubuntu-setup-notes.md`: old Ubuntu setup checklist (a fenced shell snippet, not runnable). Some lines are stale; the `.zshrc` is macOS-specific (Homebrew, conda), so it won't load cleanly on Ubuntu.

## Things that aren't obvious

- `~/.zshrc` is a **copy** of the repo's `.zshrc`, not a symlink. Editing the repo file changes nothing on the machine until it is copied over, and the live file can drift from the repo.
- Syntax-check shell changes with `zsh -n <file>`. To confirm functions load: `zsh -c 'for f in scripts/*.zsh; do source $f; done; whence -w <function>'`.
- The `plugins=(...)` line in `.zshrc` needs `zsh-autosuggestions` and `zsh-syntax-highlighting` cloned into `$ZSH_CUSTOM/plugins` by hand. `zsh-syntax-highlighting` must stay last in the list.
- The `clean_all` functions in `scripts/cleanup.zsh` are destructive (they delete `node_modules`, run `flutter clean`, `gradle clean` and `git gc --prune=now`) and run over `~/Dev`. Don't run them to test.
- `commit_wip` in `scripts/git.zsh` calls an external quote API that is probably dead, and it runs `git add -A` and `git push`.
- VS Code settings are exported from the UI (File > Preferences > Profiles > Export Profile) into `vscode/vscode_allan.code-profile`. There is no hand-written `settings.json`.
