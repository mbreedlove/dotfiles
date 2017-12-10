#!/bin/bash

# Linux does this right, OS X needs this shim
command -v realpath >/dev/null 2>&1 || realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

echo "Installing zprezto..."
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${HOME}/.zprezto"

shopt -s extglob
for rcfile in "${HOME}"/.zprezto/runcoms/!(README.md); do
    ln -s "$rcfile" "${HOME}/.${rcfile##*/}"
done

rm -f ~/.zshrc
ln -s "$(realpath ./zsh/zshrc)" "${HOME}/.zshrc"

echo "Installing Vim configuration and plugins..."
VIM_DIRS=( backup tmp )
ln -s $(realpath ./vim) "${HOME}/.vim"
for vimdir in "${VIM_DIRS[@]}"; do
  mkdir "${HOME}/.vim/$vimdir"
done
vim +PlugInstall +qall

echo "Installing tmux configuration..."
for config in $(realpath ./tmux)/*; do
  ln -s "$config" "${HOME}/.${config##*/}"
done

echo "Installing tmux package manager..."
git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
tmux new-session \; run-shell "${HOME}/.tmux/plugins/tpm/bindings/install_plugins" \; kill-server

echo "Installing git configuration..."
for config in $(realpath ./git)/*; do
  ln -s "$config" "${HOME}/.${config##*/}"
done

echo "Installing Powerline fonts..."
git clone https://github.com/powerline/fonts.git
cd fonts/
./install.sh
cd ..
rm -rf fonts

echo "Done!"
