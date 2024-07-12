#!/usr/bin/env bash

if [ ! -f $HOME/.local/bin/micromamba ]; then
  ./micromamba-releases/install.sh
  mkdir -p $HOME/Applications/micromamba
fi
