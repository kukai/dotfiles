#!/bin/bash

DOTFILES=(.tmux.conf .zshrc .vimrc)

for file in ${DOTFILES[@]}
do
  ln -fnsv $PWD/$file $HOME/$file
done

if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
fi

if [ ! -d ~/.zplug ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi
