#!/bin/bash

echo "ln -fs $HOME/envfiles/.bash_aliases $HOME/"
ln -fs $HOME/envfiles/.bash_aliases $HOME/

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
echo "ln -fs $HOME/envfiles/.dein.toml $HOME/"
ln -fs $HOME/envfiles/.dein.toml $HOME/
echo "ln -fs $HOME/envfiles/.dein_lazy.toml $HOME/"
ln -fs $HOME/envfiles/.dein_lazy.toml $HOME/
