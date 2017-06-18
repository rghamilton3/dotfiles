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
alias update='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade && sudo apt-get autoremove'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown -h now'

alias ws="cd ~/workspace"
alias src="cd ~/source_builds"
alias rstmp="sudo mount -o remount,size=8G,noatime /tmp"
alias clntmp="su -c 'for i in /tmp/* ; do rm -r \"$i\" ; done'"

alias rosycm="curl https://gist.githubusercontent.com/galou/92a2d05dd772778f86f2/raw/734b21381d2627fdbf050864e2e4f0bb6f3f2598/.ycm_extra_conf.py"
