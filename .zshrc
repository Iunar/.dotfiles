
# Created by newuser for 5.9

# Set ZDOTDIR to this file path in ~/.zshenv to load from .dotfiles directory

# colors
# palette -> https://lospec.com/palette-list/resurrect-64
PURPLE='#a884f3'
GREEN='#1ebc73'
RED='#e83b3b'
BLUE='#4d9be6'
MINT='#30e1b9'
GOLD='#f9c22b'

# prompt components
NEW_LINE=$'\n'
TAB='    '
DATE_TIME="%F{$MINT}%@%f"
WORKING_DIR="%F{$BLUE}%~%f"
HOST="%F{$PURPLE}%n%f%F{$GREEN}@%f%F{$RED}erebor%f"
PROMPT="%F{$GOLD}$%f"

# machine name escape character not working?
# Escape ''$ for home-manager
PS1="${DATE_TIME} ${WORKING_DIR} ${NEW_LINE}${TAB} ${HOST} ${PROMPT} "

# Why
cd $HOME
