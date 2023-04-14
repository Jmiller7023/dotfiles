#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
alias la='ls --all'
alias vi=' vim'
export GPG_TTY=$(tty)

# Import colorscheme from 'wal' asynchronously
(cat ~/.cache/wal/sequences &)

# To add support for TTYs
source ~/.cache/wal/colors-tty.sh