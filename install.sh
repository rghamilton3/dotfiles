#! /bin/bash

INSTALL_DIR="$PWD"

installPythonRequiremnts() {
    echo "*** Installing pip..."
    wget https://bootstrap.pypa.io/get-pip.py
    sudo -H python get-pip.py
    rm get-pip.py

    echo "*** Installing virtualenv..."
    sudo -H pip install virtualenv
    sudo rm -rf ~/get-pip.py ~/.cache/pip

    echo "*** Installing pyenv..."
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
}

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
                                break;;
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

echo "Install required software from repos?";
select ans in "Yes" "No" "Quit"; do
    case $ans in
        Yes )
            sudo apt install tmux zsh vim-gtk python{,3}-dev wget git;
            break;;
        No )
            break;;
        Quit )
            echo "Quitting...";
            exit;;
    esac
done

echo "Install Python requirements?"
select ans in "Yes" "No" "Quit"; do
    case $ans in
        Yes )
            installPythonRequiremnts
            break;;
        No )
            break;;
        Quit )
            echo "Quitting...";
            exit;;
    esac
done

echo "*** Installing config files and directories..."

# MISC
moveFileIfExists "$HOME/.xprofile"
ln -sv "$INSTALL_DIR/xprofile" "$HOME/.xprofile"

# ZSH
moveFileIfExists "$HOME/.zshrc"
ln -sv "$INSTALL_DIR/zsh/zshrc" "$HOME/.zshrc"

moveFileIfExists "$HOME/.zshenv"
ln -sv "$INSTALL_DIR/zsh/zshenv" "$HOME/.zshenv"

# VIM
moveFileIfExists "$HOME/.vimrc"
ln -sv "$INSTALL_DIR/vim/vimrc" "$HOME/.vimrc"

moveFileIfExists "$HOME/.vim"
ln -sv "$INSTALL_DIR/vim" "$HOME/.vim"

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

# TMUX
moveFileIfExists "$HOME/.tmux.conf"
ln -sv "$INSTALL_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

moveFileIfExists "$HOME/.tmux"
ln -sv "$INSTALL_DIR/tmux" "$HOME/.tmux"

# TERMITE
if [[ ! -d "$HOME"/.config/termite ]]
then
    mkdir -p "$HOME"/.config/termite
else
    moveFileIfExists "$HOME"/.config/termite/config
fi
ln -sv "$INSTALL_DIR"/termite/config "$HOME"/.config/termite/config
