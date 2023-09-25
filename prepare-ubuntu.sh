#!/bin/bash

# # === Update apt-get and install initial things
# sudo apt update
# sudo apt install curl git


# Install chrome
# TBD


# Install vscode
# snap install code
# cp ./vscode/settings.json ~/.config/Code/User/
# cp ./vscode/keybindings.json ~/.config/Code/User/


# # === Install and config Github CLI
# # this will authenticate, create a ssh key and add to github
# sudo apt install gh
# gh auth login
# git config --global user.email "allanbrados@gmail.com"
# git config --global user.name "Allan David"


# # === Install Oh My Zsh
# sudo apt install -y zsh
# sudo chsh -s /usr/bin/zsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# cp ./.zshrc ~/
# source ~/.zshrc # if this breaks, use source in terminal


# # === Install Diff so Fancy
# # install a took to make diffs prettier
# sh ./git/pretty-diff.sh


# # === Install ASDF
# git clone https://github.com/asdf-vm/asdf.git ~/.asdf
# # === Install Erlang using ASDF
# # https://github.com/asdf-vm/asdf-erlang#before-asdf-install
# sudo apt-get -y install build-essential autoconf m4 libncurses5-dev libwxgtk3.0-gtk3-dev libwxgtk-webview3.0-gtk3-dev \
#     libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk
# asdf plugin add erlang
# asdf install erlang 26.1
# asdf global erlang 26.1
# # === Install Elixir using ASDF
# asdf plugin add elixir
# asdf install elixir 1.15.6-otp-26
# asdf global elixir 1.15.6-otp-26