#!/bin/bash

# print error message on error
trap 'echo command \"$BASH_COMMAND\" FAILED with code $?' ERR

set -e # abort on error


echo "=== Config links"

read -p "Create config links? WARNING! Existing config files will be overwritten! [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    ln -sfv ~/.dotfiles/shell/bash_profile ~/.bash_profile
    ln -sfv ~/.dotfiles/shell/profile ~/.profile
    ln -sfv ~/.dotfiles/shell/bashrc ~/.bashrc
    ln -sfv ~/.dotfiles/shell/inputrc ~/.inputrc

    ln -sfv ~/.dotfiles/others/tmux.conf ~/.tmux.conf

    mkdir -pv ~/.config
    ln -sfv ~/.dotfiles/powerline ~/.config/powerline

    ln -sfv ~/.dotfiles/vim/vimrc ~/.vimrc
    mkdir -pv ~/.vim/colors
    ln -sfv ~/.dotfiles/vim/colors/* ~/.vim/colors/
    mkdir -pv ~/.config/nvim
    ln -sfv ~/.dotfiles/vim/nvim_init.vim ~/.config/nvim/init.vim

    ln -sfv ~/.dotfiles/git/gitconfig ~/.gitconfig
    ln -sfv ~/.dotfiles/ssh/config ~/.ssh/config
else
    echo "skipping config links"
fi

echo
echo "=== Apt packages"


read -p "Install git from ppa:git-core? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo add-apt-repository ppa:git-core/ppa -y
    sudo apt-get update
    sudo apt-get install git -y
    git --version
else
    echo "skipping git"
fi

read -p "Install neovim python3-pip tree fonts-powerline? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo apt-get update
    sudo apt-get install -y neovim python3-pip tree

    if grep -q Microsoft /proc/version; then
      echo
      echo "Wsl detected. fonts-powerline skipped."
      echo "Install fonts in windows from https://github.com/powerline/fonts"
    else
      sudo apt-get install -y fonts-powerline
    fi

    echo
    echo "Don't forget to set the terminal font to a powerline patched font!"

else
    echo "skipping apt packages"
fi

echo
echo "=== FZF"

read -p "Install fzf? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
else
    echo "skipping fzf"
fi


echo
echo "=== Tmux Plugin Manager"

read -p "Install Tmux Plugin Manager? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "skipping Tmux Plugin Manager"
fi


read -p "Install Vundle (vim plugin manger)? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim -c 'PluginInstall' -c 'qa!'
    nvim -c 'PluginInstall' -c 'qa!'
else
    echo "skipping vundle"
fi

echo
echo "=== Powerline"

read -p "Install powerline-status powerline-gitstatus? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    pip3 install powerline-status powerline-gitstatus
else
    echo "skipping Powerline"
fi


# { set +x; } 2>/dev/null ;  echo "SUCCESS" ; set -x
echo
echo "SUCCESS"

