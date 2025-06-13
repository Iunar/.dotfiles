if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting
set -gx EDITOR nvim

source $HOME/.cache/wal/colors.fish

fastfetch -l arch_small -S OS:Uptime:Memory:Disk:WM:terminal
