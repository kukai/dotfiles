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

if [ ! -d ~/.zplug ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi
