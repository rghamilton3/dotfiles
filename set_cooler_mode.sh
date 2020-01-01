#!/usr/bin/env bash
MODE=3
if [[ "$1" != "" ]]; then
    MODE="$1"
fi
sudo opencorsairlink --device=0 --pump mode="$MODE"

for i in {1..4}; do
    sudo opencorsairlink --device=0 --fan channel="$i",mode="$MODE";
done

