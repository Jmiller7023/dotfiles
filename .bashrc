#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
alias ls='exa'
alias la='exa --long --header --icons --git'
alias vi=' vim'
alias top='htop'

# Create aliases for devour
alias firefox='devour firefox'
alias vlc='devour vlc'
alias mpv='devour mpv'
alias zathura='devour zathura'
alias sxiv='devour sxiv'
alias calculator='devour qalculate-gtk'
alias qalculate-gtk='devour qalculate-gtk'
alias spotify='devour spotify-launcher'
alias wireshark='sudo devour wireshark'
alias audacity='export GDK_SCALE=2; export GDK_DPI_SCALE=0.5; devour  audacity'
alias thunar='export GDK_SCALE=2; export GDK_DPI_SCALE=0.5; devour thunar'
alias qbittorrent='QT_SCALE_FACTOR=2 devour qbittorrent'
export GPG_TTY=$(tty)

# Import colorscheme from 'wal' asynchronously
(cat ~/.cache/wal/sequences &)

# To add support for TTYs
source ~/.cache/wal/colors-tty.sh