#!/bin/bash

source ~/envfiles/scripts/git_display_setup.sh
echo "source ~/envfiles/scripts/git-prompt_setup.sh"

echo -e  "
# PS1 setting
export PS1='\[\e[38;5;2m\]\u@\h \[\e[0m\]\[\e[38;5;26m\]\w \[\e[1;31m\]$(__git_ps1)\[\e[0m\]\n\$ '
" >> $HOME/.bashrc

source ~/.bashrc
echo "source ~/.bashrc"

