#!/bin/bash

source "${BASH_SOURCE%/*}/utils/text.sh"

# Force root.
if [ "$(id -u)" -ne 0 ]; then
  echo -e "${TXT_FAIL}This script must be run using sudo!$TXT_RESET" >&2
  exit 1
fi

echo -e "${TXT_INFO}Setting up environment for current user...$TXT_RESET"

source utils/install.sh

# Update packages.
update_package_manager

install_package htop;
install_package tmux;

# Add source to profile. 
append_to_file $HOME/.bashrc "source $HOME/dotfiles/configuration/bashrc.sh"

# Map bash_profile to bashrc.
append_to_file $HOME/.bash_profile "source $HOME/dotfiles/configuration/bash_profile.sh"

# Add source to vimrc.
append_to_file $HOME/.vimrc "source $HOME/dotfiles/configuration/vimrc"

# Add source to tmux.
append_to_file $HOME/.tmux.conf "source-file $HOME/dotfiles/configuration/tmux"
