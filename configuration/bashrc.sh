#!/bin/bash
export DOTFILES=~/dotfiles

export VISUAL=vim
export EDITOR="$VISUAL"

source $DOTFILES/utils/text.sh
source $DOTFILES/git-prompt.sh

export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1

export PS1='\u \W$(__git_ps1 " (%s)")\$ '
export PROMPT_COMMAND='__git_ps1 "$TXT_DIM$TXT_MAGENTA\u$TXT_RESET \W" "\\\$ "'
