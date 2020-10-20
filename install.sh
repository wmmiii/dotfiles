#!/bin/bash

USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

source "${BASH_SOURCE%/*}/utils/text.sh"

# Force root.
if [ "$(id -u)" -ne 0 ]; then
  printf "${TXT_FAIL}This script must be run using sudo!$TXT_RESET\n" >&2
  exit 1
fi

printf "${TXT_INFO}Setting up environment for current user...$TXT_RESET\n"

source utils/install.sh

# Update packages.
update_package_manager

install_package vim;
install_package htop;
install_package tmux;

# Add source to profile. 
append_to_file $USER_HOME/.bashrc "source $USER_HOME/dotfiles/configuration/bashrc.sh"

# Add source to vimrc.
append_to_file $USER_HOME/.vimrc "source $USER_HOME/dotfiles/configuration/vimrc"

# Add source to tmux.
append_to_file $USER_HOME/.tmux.conf "source-file $USER_HOME/dotfiles/configuration/tmux"
