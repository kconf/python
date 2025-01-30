export MAMBA_ROOT_PREFIX=~/Applications/micromamba
eval "$(~/.local/bin/micromamba shell hook -s zsh)"
micromamba activate base

export RYE_HOME=$HOME/Applications/rye
source $RYE_HOME/env
