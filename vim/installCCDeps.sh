#! /bin/sh
#
# installCCDeps.sh
# Copyright (C) 2017 rghamilton3 <rghamilton3@ArchTop>
#
# Distributed under terms of the MIT license.
#

installPkg() {
    # Use Yaourt if installed
    # No need to use sudo if so
    if pacman -Qi yaourt > /dev/null
    then
        INSTALLER=yaourt
    else
        INSTALLER="sudo pacman"
    fi

    if ! pacman -Qi "$1" > /dev/null
    then
        "$INSTALLER" -Sy "$1"
    fi
}

installPkg "clang"
installPkg "ncurses"
installPkg "libz"
installPkg "xz"
installPkg "pthread_workqueue-git"
installPkg "lua"
