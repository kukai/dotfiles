#!/bin/bash

DOTFILES=(.tmux.conf .zshrc .vimrc)

for file in ${DOTFILES[@]}
do
  ln -fnsv $PWD/$file $HOME/$file
done

if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
fi

if [ ! -d ~/.goenv ]; then
  goenv install 1.10.0
  goenv global 1.10.0
fi

if [ ! -d ~/.nodebrew ]; then
  curl -L git.io/nodebrew | perl - setup
  nodebrew install-binary stable
  nodebrew use stable
fi

if [ ! -d ~/.pyenv ]; then
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  git clone https://github.com/yyuu/pyenv-pip-rehash.git ~/.pyenv/plugins/pyenv-pip-rehash
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  pyenv install 2.7.15
  pyenv install 3.6.6
  pyenv global 3.6.6
fi

if [ ! -d ~/.zplug ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi
