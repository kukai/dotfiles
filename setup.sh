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

if [ ! -f ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# ~/.config/<app> directories often mix config with runtime state (logs,
# sockets, caches), so link individual files rather than whole directories.
mkdir -p ~/.config/herdr
ln -fnsv $PWD/config/herdr/config.toml ~/.config/herdr/config.toml
