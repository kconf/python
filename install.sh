#!/usr/bin/env bash

if [ ! -f $HOME/.local/bin/micromamba ]; then
  "${SHELL}" <(curl -L micro.mamba.pm/install.sh)
  mkdir -p $HOME/micromamba
fi
