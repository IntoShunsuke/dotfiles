#!/bin/bash

echo "ln -fs $HOME/envfiles/.bash_aliases $HOME/"
ln -fs $HOME/envfiles/.bash_aliases $HOME/

# neovim
echo "mkdir -p $HOME/.config/nvim"
mkdir -p $HOME/.config/nvim
echo "ln -fs $HOME/envfiles/init.vim $HOME/"
ln -fs $HOME/envfiles/init.vim $HOME/.config/nvim/
echo "ln -fs $HOME/envfiles/.dein.toml $HOME/"
ln -fs $HOME/envfiles/.dein.toml $HOME/
echo "ln -fs $HOME/envfiles/.dein_lazy.toml $HOME/"
ln -fs $HOME/envfiles/.dein_lazy.toml $HOME/
