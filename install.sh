#! /bin/bash

INSTALL_DIR="$PWD"

HOME_INSTALL=(xprofile vimrc vim zshrc zshenv tmux.conf tmux)

echo "*** Installing required software from repos..."
sudo apt install tmux zsh vim-gtk python{,3}-dev wget git

echo "*** Installing Python requirements..."
wget https://bootstrap.pypa.io/get-pip.py
sudo -H python get-pip.py
rm get-pip.py

sudo -H pip install virtualenv virtualenvwrapper
sudo rm -rf ~/get-pip.py ~/.cache/pip

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv


moveFileIfExists() {
    if [[ -h "$1" ]]  
    then
        echo "Remove symlink ${1}?"
        select ans in "Yes" "No" "Quit"; do
            case $ans in
                Yes )
                    rm "$1";
                    echo "Removed symlink ${1}";
                    break;;
                No )
                    echo "Move symlink ${1}?"
                    select moveAns in "Yes" "No"; do
                        case $moveAns in
                            Yes ) 
                                mv "$1" "$1".bak; 
                                echo "Moved symlink ${1} to ${1}.bak?"
                                break;;
                            No )
                                echo "Quitting...";
                                exit;;
                        esac
                    done
                    break;;
                Quit )
                    echo "Quitting...";
                    exit;;
            esac
        done
    elif [[ -d "$1" ]] || [[ -e "$1" ]] 
    then
        mv "$1" "$1".bak
    fi
}

echo "*** Installing config files and directories..."
for item in ${HOME_INSTALL[@]}; do
    moveFileIfExists "$HOME"/.${item}
    ln -sv "$INSTALL_DIR"/${item} "$HOME"/.${item}
done

# VIM
if [[ -d "$INSTALL_DIR"/vim/autoload ]]
then
    moveFileIfExists "$INSTALL_DIR"/vim/autoload/plug.vim
else
    mkdir -p "$INSTALL_DIR"/vim/autoload
fi
ln -sv "$INSTALL_DIR"/vim/vim-plug/plug.vim "$INSTALL_DIR"/vim/autoload/plug.vim

if [[ ! -d "$INSTALL_DIR"/vim/undo ]]
then
    mkdir -p "$INSTALL_DIR"/vim/undo
fi

# TERMITE
if [[ ! -d "$HOME"/.config/termite ]]
then
    mkdir -p "$HOME"/.config/termite
else
    moveFileIfExists "$HOME"/.config/termite/config
fi
ln -sv "$INSTALL_DIR"/termite/config "$HOME"/.config/termite/config
