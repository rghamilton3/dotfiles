alias curl="curl -OL#"
alias ping3="ping -c 3"
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmdir='rmdir -v'
alias ln='ln -v'
alias chmod="chmod -c"
alias chown="chown -c"
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias ls='ls --color=auto --human-readable --group-directories-first --classify'
alias update='sudo apt update && sudo apt upgrade && sudo apt dist-upgrade && sudo apt autoremove'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown -h now'

alias ws="cd ~/workspace"
alias src="cd ~/Storage/source_builds"

alias make='make -j"$(nproc)"'
