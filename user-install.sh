#!/bin/bash

echo "=== SSH"

cd; mkdir .ssh; chmod 700 .ssh; cd .ssh; touch authorized_keys; chmod 600 authorized_keys


echo "=== VIM"

rm -R ~/.vim ~/.vimrc
git clone https://github.com/imbolc/.vim
ln -s ~/.vim/.vimrc ~
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

update-alternatives --set editor /usr/bin/vim.nox


# Enable sudo autocomplete
echo "complete -cf sudo" >> ~/.bashrc
