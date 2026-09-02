#!/bin/bash

# Symlink src to dst, backing up any pre-existing real file (not already
# one of our symlinks) instead of silently clobbering it.
link_file() {
  local src=$1 dst=$2
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv -v "$dst" "$dst.bak.$(date +%Y%m%d%H%M%S)"
  fi
  ln -fnsv "$src" "$dst"
}

DOTFILES=(.tmux.conf .zshrc .vimrc)

for file in ${DOTFILES[@]}
do
  link_file $PWD/$file $HOME/$file
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
link_file $PWD/config/herdr/config.toml ~/.config/herdr/config.toml
