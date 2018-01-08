#! /bin/sh
#
# installYCM.sh
# Copyright (C) 2017 rghamilton3 <rghamilton3@gmail.com>
#
# > /dev/null redirects unneeded output from stdout
# to nowhere
#
YCM_DIR="$HOME"/.vim/plugged/YouCompleteMe
BUILD_DIR="$YCM_DIR"/build

CLANG_VER=5.0.1
CLANG_FILE=clang+llvm-"$CLANG_VER"-x86_64-linux-gnu-ubuntu-14.04
CLANG_URL=http://releases.llvm.org/"$CLANG_VER"/"$CLANG_FILE".tar.xz

installPkg() {
    # Use pacaur if installed
    # No need to use sudo if so
    if pacman -Qi yaourt > /dev/null
    then
        INSTALLER=pacaur
    else
        INSTALLER="sudo pacman"
    fi

    if ! pacman -Qi "$1" > /dev/null
    then
        "$INSTALLER" -Sy "$1"
    fi
}

mkBuildDir() {
    if [ ! -d "$BUIlD_DIR" ]
    then
        mkdir -p "$BUILD_DIR"
    fi
}

downloadClang() {
    CLANG_DIR="$PWD"/"$CLANG_FILE"
    echo "$CLANG_DIR"

    if [ -d "$CLANG_FILE" ]
    then
        echo "$CLANG_FILE already exists"
        return
    fi

    if  pacman -Qi wget > /dev/null 
    then
        wget "$CLANG_URL"
    elif  pacman -Qi curl > /dev/null
    then
        curl "$CLANG_URL"
    else
        echo "Wget and Curl not found. What program should be used? (Just enter the cmd and flags without the url. No input exits)"
        read DOWNLOADER
        if [ -n "$DOWNLOADER" ]
        then
            "$DOWNLOADER" "$CLANG_URL"
        else
            echo "No program provided. Exiting"
            exit
        fi
    fi

    tar xf "$CLANG_FILE".tar.xz
}

cd "$YCM_DIR"
mkBuildDir
cd "$BUILD_DIR"
#downloadClang

installPkg "cmake"
installPkg "python"
installPkg "python2"

cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON . "$YCM_DIR"/third_party/ycmd/cpp
cmake --build . --target ycm_core --config Release
