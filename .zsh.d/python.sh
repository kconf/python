if [[ -f ~/.local/bin/micromamba ]]; then
  export MAMBA_ROOT_PREFIX=~/Applications/micromamba
  eval "$(~/.local/bin/micromamba shell hook -s zsh)"
  micromamba activate base
fi

if [[ -d $HOME/Applications/rye ]]; then
  export RYE_HOME=$HOME/Applications/rye
  source $RYE_HOME/env
fi
