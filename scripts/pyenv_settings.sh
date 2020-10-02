#!/bin/bash

# required libraries
# sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

# If you get an error with openssl.
# sudo apt-add-repository -y ppa:rael-gc/rvm
# sudo apt-get update

if type "pyenv" > /dev/null 2>&1; then
  echo "pyenv is already installed."
else
  git clone git://github.com/yyuu/pyenv.git ~/.pyenv
  git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

  echo -e  '
  # pyenv settings
  export PYENV_ROOT="${HOME}/.pyenv"
  if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
  fi
  ' >> $HOME/.bashrc
  
  source $HOME/.bashrc

  # install 2 and 3 
  pyenv install 2.7.16
  pyenv install 3.8.6

  # create virtualenv for nvim
  pyenv virtualenv 2.7.16 nvim-python2
  pyenv activate nvim-python2
  pyenv virtualenv 3.8.6 nvim-python3
  pyenv activate nvim-python3
  
fi

