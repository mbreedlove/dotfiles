#!/bin/bash

command -v realpath >/dev/null 2>&1 || realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

echo "Installing zprezto..."
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${HOME}/.zprezto"

shopt -s extglob
for rcfile in "${HOME}"/.zprezto/runcoms/!(README.md); do
    ln -s "$rcfile" "${HOME}/.${rcfile##*/}"
done

echo "Installing Vim configuration and plugins..."
VIM_DIRS=( backup tmp )
ln -s $(realpath ./vim) "${HOME}/.vim"
for vimdir in "${VIM_DIRS[@]}"; do
  mkdir "${HOME}/.vim/$vimdir"
done
vim +PlugInstall +qall


echo "Done!"
