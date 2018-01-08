#! /bin/bash

INSTALL_DIR="$PWD"

installPythonRequiremnts() {
    echo "*** Installing pip..."
    pacaur -S --needed python{2,}-{setuptools,pip}

    echo "*** Installing virtualenv..."
    sudo -H pip install virtualenv
    sudo rm -rf ~/get-pip.py ~/.cache/pip

    echo "*** Installing pyenv..."
    pacaur -S --needed pyenv
    git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
}

run_ln=true
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
                                run_ln=false
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
            sudo pacman -S --needed  tmux zsh vim curl wget git hub cmake;
            git clone https://aur.archlinux.org/pacaur;
            cd pacaur;
            makepkg -si --needed;
            cd ..;
            rm -rf pacaur;
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
if [ "$run_ln" = true ]; then
    ln -sv "$INSTALL_DIR/xprofile" "$HOME/.xprofile"
else
    run_ln=true
fi

moveFileIfExists "$HOME/.clang-format"
if [ "$run_ln" = true ]; then
    ln -sv "$INSTALL_DIR/clang-format" "$HOME/.clang-format"
else
    run_ln=true
fi

moveFileIfExists "$HOME/.ctags"
if [ "$run_ln" = true ]; then
    ln -sv "$INSTALL_DIR/ctags" "$HOME/.ctags"
else
    run_ln=true
fi

# ZSH
moveFileIfExists "$HOME/.zshrc"
if [ "$run_ln" = true ]; then
    ln -sv "$INSTALL_DIR/zsh/zshrc" "$HOME/.zshrc"
else
    run_ln=true
fi

moveFileIfExists "$HOME/.zshenv"
if [ "$run_ln" = true ]; then
    ln -sv "$INSTALL_DIR/zsh/zshenv" "$HOME/.zshenv"
else
    run_ln=true
fi

if [[ ! -d "$HOME"/.zsh/completions ]]
then
    mkdir -p "$HOME"/.zsh/completions
fi
moveFileIfExists "$HOME"/.zsh/completions/_hub
if [ "$run_ln" = true ]; then
    ln -sv "$INSTALL_DIR/zsh/hub.zsh_completion" "$HOME/.zsh/completions/_hub"
else
    run_ln=true
fi

# VIM
moveFileIfExists "$HOME/.vimrc"
if [ "$run_ln" = true ]; then
    ln -sv "$INSTALL_DIR/vim/vimrc" "$HOME/.vimrc"
else
    run_ln=true
fi

moveFileIfExists "$HOME/.vintrc.yaml"
if [ "$run_ln" = true ]; then
    ln -sv "$INSTALL_DIR/vim/vintrc.yaml" "$HOME/.vintrc.yaml"
else
    run_ln=true
fi

moveFileIfExists "$HOME/.vim"
if [ "$run_ln" = true ]; then
    ln -sv "$INSTALL_DIR/vim" "$HOME/.vim"
else
    run_ln=true
fi

if [[ -d "$HOME"/vim/autoload ]]
then
    moveFileIfExists "$HOME"/vim/autoload/plug.vim
else
    mkdir -p "$HOME"/vim/autoload
fi
if [ "$run_ln" = true ]; then
    ln -sv "$INSTALL_DIR"/vim/vim-plug/plug.vim "$HOME"/vim/autoload/plug.vim
else
    run_ln=true
fi

if [[ ! -d "$HOME"/vim/undo ]]
then
    mkdir -p "$HOME"/vim/undo
fi

# TMUX
moveFileIfExists "$HOME/.tmux.conf"
if [ "$run_ln" = true ]; then
    ln -sv "$INSTALL_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
else
    run_ln=true
fi

moveFileIfExists "$HOME/.tmux"
if [ "$run_ln" = true ]; then
    ln -sv "$INSTALL_DIR/tmux" "$HOME/.tmux"
else
    run_ln=true
fi

# TERMITE
if [[ ! -d "$HOME"/.config/termite ]]
then
    mkdir -p "$HOME"/.config/termite
else
    moveFileIfExists "$HOME"/.config/termite/config
fi
if [ "$run_ln" = true ]; then
    ln -sv "$INSTALL_DIR"/termite/config "$HOME"/.config/termite/config
else
    run_ln=true
fi
