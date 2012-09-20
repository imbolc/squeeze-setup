#!/bin/bash

echo "=== SSH"

cd; mkdir .ssh; chmod 700 .ssh; cd .ssh; touch authorized_keys; chmod 600 authorized_keys


echo "=== VIM"

rm -R ~/.vim ~/.vimrc
git clone https://github.com/imbolc/.vim
ln -s ~/.vim/.vimrc ~
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

update-alternatives --set editor /usr/bin/vim.nox


echo "=== Enable sudo autocomplete"

echo "complete -cf sudo" >> ~/.bashrc

echo "=== Bash aliases"
cat > ~/.bash_aliases << EOF
alias nginx-restart='sudo /etc/init.d/nginx configtest && sudo /etc/init.d/nginx restart'
alias chmod-standard="find ./ -type d | xargs chmod -v 755 ; find ./ -type f | xargs chmod -v 644"
EOF

echo "=== Mercurial config"
cat > ~/.hgrc << EOF
[ui]
username = $(whoami) <$(whoami)@$(hostname)>
EOF

echo "=== Git config"
git config --global user.name $(whoami)
git config --global user.email $(whoami)@$(hostname)
