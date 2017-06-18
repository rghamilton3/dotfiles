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
    elif [[ -d "$1" ]] || [[ -e "$!" ]] 
    then
        mv "$1" "$1".bak
    fi
}

moveFileIfExists "$HOME"/.vimrc
ln -sv "$HOME"/.dotfiles/vim/vimrc "$HOME"/.vimrc

moveFileIfExists "$HOME"/.vim
ln -sv "$HOME"/.dotfiles/vim/ "$HOME"/.vim

moveFileIfExists "$HOME"/.zshrc
ln -sv "$HOME"/.dotfiles/zsh/zshrc "$HOME"/.zshrc

moveFileIfExists "$HOME"/.zshenv
ln -sv "$HOME"/.dotfiles/zsh/zshenv "$HOME"/.zshenv

moveFileIfExists "$HOME"/.tmux.conf
ln -sv "$HOME"/.dotfiles/tmux/tmux.conf "$HOME"/.tmux.conf

moveFileIfExists "$HOME"/.tmux
ln -sv "$HOME"/.dotfiles/tmux/ "$HOME"/.tmux

moveFileIfExists "$HOME"/.jshintrc
ln -sv "$HOME"/.dotfiles/node/jshintrc "$HOME"/.jshintrc

if [[ ! -d "$HOME"/.config/termite ]]
then
    mkdir -p "$HOME"/.config/termite
else
    moveFileIfExists "$HOME"/.config/termite/config
fi
ln -sv "$HOME"/.dotfiles/termite/config "$HOME"/.config/termite/config
