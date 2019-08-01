#! /bin/bash -x

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

    echo "*** Installing pyenv build requirements..."
    sudo dnf install gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel
}

installHub() {
	echo "*** Downloading hub..."
	wget https://github.com/github/hub/releases/download/v2.12.3/hub-linux-amd64-2.12.3.tgz

	echo "*** Installing hub..."
	tar xf hub-linux-amd64-2.12.3.tgz -C ~/.local/bin

	rm hub-linux-amd64-2.12.3.tgz
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
            sudo dnf install -y tmux zsh vim-X11 python{,3}-devel wget git autojump autojump-zsh cmake gcc-c++ make;
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

echo "Install hub?"
select ans in "Yes" "No" "Quit"; do
    case $ans in
        Yes )
            installHub
            break;;
        No )
            break;;
        Quit )
            echo "Quitting...";
            exit;;
    esac
done

echo "Set ZSH as default shell?"
select ans in "Yes" "No" "Quit"; do
    case $ans in
        Yes )
            chsh -s $(which zsh)
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

if [[ -d "$HOME"/.vim/autoload ]]
then
    moveFileIfExists "$HOME"/.vim/autoload/plug.vim
else
    mkdir -p "$HOME"/.vim/autoload
fi
if [ "$run_ln" = true ]; then
    ln -sv "$INSTALL_DIR"/vim/vim-plug/plug.vim "$HOME"/.vim/autoload/plug.vim
else
    run_ln=true
fi

if [[ ! -d "$HOME"/.vim/undo ]]
then
    mkdir -p "$HOME"/.vim/undo
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
