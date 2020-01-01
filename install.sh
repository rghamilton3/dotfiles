#! /usr/bin/env bash

INSTALL_DIR="$PWD"

installTermite() {
    sudo apt install -y g++ libgtk-3-dev gtk-doc-tools gnutls-bin valac intltool libpcre2-dev libglib3.0-cil-dev libgnutls28-dev libgirepository1.0-dev libxml2-utils gperf build-essential
    mkdir -p $HOME/source_builds
    cd $HOME/source_builds
    git clone https://github.com/thestinger/vte-ng.git
    echo export LIBRARY_PATH="/usr/include/gtk-3.0:$LIBRARY_PATH"
    cd vte-ng && ./autogen.sh && make && sudo make install
    cd ..

    git clone --recursive https://github.com/thestinger/termite.git
    cd termite && make && sudo make install
    sudo ldconfig
    sudo mkdir -p /lib/terminfo/x
    sudo ln -s /usr/local/share/terminfo/x/xterm-termite /lib/terminfo/x/xterm-termite
    cd "$INSTALL_DIR"
}

installPythonRequiremnts() {
    # Check if pip is already installed for Python 2 or 3
    pip_needed=()
    if ! [[ -x "$(command -v pip2)" ]]; then
        pip_needed+=(python2)
    fi
    if ! [[ -x "$(command -v pip3)" ]]; then
        pip_needed+=(python3)
    fi

    # Install pip as needed
    if [[ ${#pip_needed[@]} ]]; then
        wget https://bootstrap.pypa.io/get-pip.py
        for ver in "${pip_needed[@]}"; do
            echo "*** Installing pip for "$ver"..."
            sudo -H "$ver" get-pip.py
        done
        sudo rm -rf get-pip.py ~/.cache/pip
    fi

    echo "*** Installing virtualenv..."
    sudo -H pip2 install virtualenv virtualenvwrapper
    sudo -H pip3 install virtualenv virtualenvwrapper
}

installPyenv() {
    echo "*** Installing pyenv..."
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

    echo "*** Installing pyenv build requirements..."
    sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
        libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
        xz-utils tk-dev
}

installOpenCorsairLink() {
    sudo apt install -y libusb-1.0-0-dev pkg-config
    git clone git@github.com:audiohacked/OpenCorsairLink.git
    cd OpenCorsairLink
    make -j$(nproc)
    sudo make install
    sudo ln -sv /usr/local/bin/OpenCorsairLink.elf /usr/local/bin/opencorsairlink
    cd ..
    sudo ln -sv "$INSTALL_DIR"/set_cooler_mode.sh /usr/local/bin/set_cooler_mode
}

enableSshAgent() {
    service_path="$HOME/.config/systemd/user"
    if ! [[ -d "$service_path" ]]; then
        mkdir -p "$service_path"
    fi
    ln -sv "$INSTALL_DIR"/ssh-agent.service "$service_path"/
    echo 'SSH_AUTH_SOCK DEFAULT="${XDG_RUNTIME_DIR}/ssh-agent.socket"' >> "$HOME"/.pam_environment
    systemctl --user enable ssh-agent.service
    systemctl --user start ssh-agent.service
}

run_ln=true
moveFileIfExists() {
    if [[ -h "$1" ]]; then
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
    elif [[ -d "$1" ]] || [[ -e "$1" ]]; then
        mv "$1" "$1".bak
    fi
}

echo "Install required software from repos?";
select ans in "Yes" "No" "Quit"; do
    case $ans in
        Yes )
            sudo apt install tmux zsh vim python{,3}-dev wget git autojump;
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

echo "Install Pyenv?"
select ans in "Yes" "No" "Quit"; do
    case $ans in
        Yes )
            installPyenv
            break;;
        No )
            break;;
        Quit )
            echo "Quitting...";
            exit;;
    esac
done

echo "Install Termite?"
select ans in "Yes" "No" "Quit"; do
    case $ans in
        Yes )
            installTermite
            termite_installed=true
            break;;
        No )
            break;;
        Quit )
            echo "Quitting...";
            exit;;
    esac
done

echo "Install OpenCorsairLink?"
select ans in "Yes" "No" "Quit"; do
    case $ans in
        Yes )
            installOpenCorsairLink
            break;;
        No )
            break;;
        Quit )
            echo "Quitting...";
            exit;;
    esac
done

echo "Enable ssh-agent service?"
select ans in "Yes" "No" "Quit"; do
    case $ans in
        Yes )
            enableSshAgent
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

#if [[ -d "$HOME"/.vim/autoload ]]
#then
#    moveFileIfExists "$HOME"/.vim/autoload/plug.vim
#else
#    mkdir -p "$HOME"/.vim/autoload
#fi
#if [ "$run_ln" = true ]; then
#    ln -sv "$INSTALL_DIR"/vim/vim-plug/plug.vim "$HOME"/.vim/autoload/plug.vim
#else
#    run_ln=true
#fi

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

# TERMITE
if [ "$termite_installed" = true ]; then
    if [[ ! -d "$HOME"/.config/termite ]]; then
        mkdir -p "$HOME"/.config/termite
    else
        moveFileIfExists "$HOME"/.config/termite/config
    fi
    if [ "$run_ln" = true ]; then
        ln -sv "$INSTALL_DIR"/termite.config "$HOME"/.config/termite/config
    else
        run_ln=true
    fi
fi
