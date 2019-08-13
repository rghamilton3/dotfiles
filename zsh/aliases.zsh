alias curl='curl -OL#'
alias ping3='ping -c 3'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmdir='rmdir -v'
alias ln='ln -v'
alias chmod='chmod -c'
alias chown='chown -c'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias ls='ls --color=auto --human-readable --group-directories-first --classify'
alias update='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade && sudo apt-get autoremove'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown -h now'

alias ws='cd ~/workspace'
alias src='cd ~/source'
alias rstmp='sudo mount -o remount,size=8G,noatime /tmp'

# User specific aliases and functions
alias asp='cd ~/workspace/aspect'
alias ct='cd ~/workspace/cert_testbed'
alias upcfg='cp ~/workspace/cert_testbed/prj_apps/tte_mgr/fsw/platform_inc/tte_mgr_platform_cfg.h ~/workspace/cert_testbed/target_defs/cert_configs/platforms/ && \
    cp ~/workspace/cert_testbed/prj_apps/tte_lib/fsw/platform_inc/tte_lib_platform_cfg.h ~/workspace/cert_testbed/target_defs/cert_configs/platforms && \
    cp ~/workspace/cert_testbed/prj_apps/tte_mgr/fsw/tbls/tte_mgr_esc.c ~/workspace/cert_testbed/target_defs/cert_configs/tables # && \ 
    cp ~/workspace/cert_testbed/prj_apps/tte_mgr/fsw/tbls/tte_mgr_pm.c ~/workspace/cert_testbed/target_defs/cert_configs/tables'
alias build='ct && make distclean && make prep && make && make install'
alias run='ct && cd build/exe/lx1 && ./core-lx1'
alias br='build && run'
alias ubr='upcfg && br'

alias gsu='git submodule update --recursive'

alias mkdb='mkdir build'
