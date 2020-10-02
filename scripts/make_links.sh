#!/bin/bash

# .bash_aliases
if [ -e $HOME/..bash_aliases ]; then
  echo "ln -fs $HOME/envfiles/.bash_aliases $HOME/"
  ln -fs $HOME/envfiles/.bash_aliases $HOME/
  echo -e  '
  # .bash_aliases
  if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
  fi
  ' >> $HOME/.bashrc

  echo -e  '
    export PS1="\[\e[38;5;2m\]\u@\h \[\e[0m\]\[\e[38;5;26m\]\w \[\e[0m\] \n\$ "
  ' >> $HOME/.bashrc
fi
 
echo "ln -fs $HOME/envfiles/.gitconfig $HOME/"
ln -fs $HOME/envfiles/.gitconfig $HOME/

# neovim
if type "nvim" > /dev/null 2>&1; then
  echo "mkdir -p $HOME/.config/nvim"
  mkdir -p $HOME/.config/nvim
  echo "ln -fs $HOME/envfiles/init.vim $HOME/"
  ln -fs $HOME/envfiles/init.vim $HOME/.config/nvim/
else
  echo "ln -fs $HOME/envfiles/init.vim $HOME/.vimrc"
  ln -fs $HOME/envfiles/init.vim $HOME/.vimrc
fi
# dein 
echo "ln -fs $HOME/envfiles/.dein.toml $HOME/"
ln -fs $HOME/envfiles/.dein.toml $HOME/
echo "ln -fs $HOME/envfiles/.dein_lazy.toml $HOME/"
ln -fs $HOME/envfiles/.dein_lazy.toml $HOME/

# snippets
echo "mkdir -p $HOME/.config/"
mkdir -p $HOME/.config/
echo "ln -fsn $HOME/envfiles/snippets/ $HOME/.config/nvim/"
ln -fsn $HOME/envfiles/snippets/ $HOME/.config/nvim/
