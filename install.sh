#!/usr/bin/env bash

if [ ! -f $HOME/.local/bin/micromamba ]; then
  ./micromamba-releases/install.sh
  mkdir -p $HOME/Applications/micromamba
fi

sudo pacman -S --needed --noconfirm python-pipx
pipx install poetry
