#! /bin/sh
#
# installYCM.sh
# Copyright (C) 2017 rghamilton3 <rghamilton3@gmail.com>
#
# > /dev/null redirects unneeded output from stdout
# to nowhere
#
YCM_DIR="$HOME"/.vim/plugged/YouCompleteMe

cd "$YCM_DIR"
git submodule update --init --recursive
./install.py --clang-completer
