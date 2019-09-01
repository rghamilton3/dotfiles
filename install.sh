#! /bin/bash

INSTALL_DIR="$HOME"/.dotfiles

sudo apt install -y zsh tmux vim

chsh rghamilton3 -s /usr/bin/zsh

# ZSH
if [[ ! -e "$HOME/.zshrc" ]]; then
    ln -s "$INSTALL_DIR/zsh/zshrc" "$HOME/.zshrc"
fi

if [[ ! -e "$HOME/.zshenv" ]]; then
    ln -s "$INSTALL_DIR/zsh/zshenv" "$HOME/.zshenv"
fi

# VIM
if [[ ! -e "$HOME/.vimrc" ]]; then
    ln -s "$INSTALL_DIR/vim/vimrc" "$HOME/.vimrc"
fi

if [[ ! -d "$HOME/.vim" ]]; then
    ln -s "$INSTALL_DIR/vim" "$HOME/.vim"
fi

if [[ ! -d "$HOME"/.vim/autoload ]]; then
    mkdir -p "$HOME"/.vim/autoload
    ln -s "$INSTALL_DIR"/vim/vim-plug/plug.vim "$HOME"/.vim/autoload/plug.vim
fi

if [[ ! -d "$HOME"/.vim/undo ]]; then
    mkdir -p "$HOME"/.vim/undo
fi

# TMUX
if [[ ! -e "$HOME/.tmux.conf" ]]; then
    ln -s "$INSTALL_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
fi

if [[ ! -e "$HOME/.tmux" ]]; then
    ln -s "$INSTALL_DIR/tmux" "$HOME/.tmux"
fi
