#!/bin/bash

# Linux does this right, OS X needs this shim
command -v realpath >/dev/null 2>&1 || realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

##
## Zsh
##
echo "Installing Zsh configuration..."
mkdir -p $HOME/.zsh
for config in $(realpath ./zsh)/*; do
  ln -s "$config" "${HOME}/.${config##*/}"
done

echo "Installing Antigen..."
git clone https://github.com/zsh-users/antigen.git $HOME/.antigen

##
## Vim
##
NVIM_DIR=$HOME/.config/nvim
echo "Installing Vim configuration and plugins..."

mkdir -p $NVIM_DIR

# install init.vim
ln -s $(realpath ./nvim)/init.vim $NVIM_DIR/init.vim

# install dein.vim
mkdir -p $NVIM_DIR/dein/repos/github.com/Shougo/dein.vim #recommended path
git clone https://github.com/Shougo/dein.vim.git \
    $NVIM_DIR/dein/repos/github.com/Shougo/dein.vim

#nvim -c "call dein#install()"

##
## Tmux
##
echo "Installing tmux configuration..."
for config in $(realpath ./tmux)/*; do
  ln -s "$config" "${HOME}/.${config##*/}"
done

echo "Installing tmux package manager..."
git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
tmux new-session \; run-shell "${HOME}/.tmux/plugins/tpm/bindings/install_plugins" \; kill-server

##
## Git
##
echo "Installing git configuration..."
for config in $(realpath ./git)/*; do
  ln -s "$config" "${HOME}/.${config##*/}"
done

##
## Powerline Fonts
##
echo "Installing Powerline fonts..."
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts/
./install.sh
cd ..
rm -rf fonts

echo "Done!"
