export HOME="/home/kami"
## Not needed for home-manager (nix)
#export ZDOTDIR="$HOME/.dotfiles/"
#export EDITOR="nvim"

export HISTFILE="$HOME/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
unsetopt HIST_SAVE_NO_DUPS       # Write a duplicate event to the history file
