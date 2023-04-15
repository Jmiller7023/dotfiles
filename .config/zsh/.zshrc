# Set the path of Oh-My-Zsh installation directory
export ZSH="$HOME/.config/.oh-my-zsh"

# Set zsh theme
ZSH_THEME="juanghurtado"

# Set the auto update mode and frequency for Oh-My-Zsh
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13

# Enable autocorrection of mistyped commands
ENABLE_CORRECTION="true"

# Set the path to the custom directory for Zsh configuration
ZSH_CUSTOM=~/.config/zsh

# Set the plugins to be used in the terminal
plugins=(git sudo)

# Load the Oh-My-Zsh shell script
source $ZSH/oh-my-zsh.sh

# Set the display to use X11 protocol
export DISPLAY=:0

# Set the path of the history file for Zsh
export HISTFILE=~/.zsh_history

# Set the maximum size of the history file
export HISTSIZE=10000

# Set the maximum number of commands to be saved in the history file
export SAVEHIST=10000

# Set the list of commands to be ignored in the history
export HISTORY_IGNORE="(ls|ls -a|cd|clear|pwd|exit|cd -|cd ..)"

# HISTORY
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.
# END HISTORY

# Load pluginsmus   
source $HOME/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.config/zsh/plugins/zsh-autopair/autopair.plugin.zsh

# Bind the forward and backward word keys
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Define some commonly used aliases
alias ls="exa --icons --group-directories-first"
alias la='exa --long --header --icons --git'
alias vi=' vim'
alias top='htop'
alias yt-best="yt-dlp --extract-audio --audio-format best "
alias yt-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias ytb-best="yt-dlp -f bestvideo+bestaudio "

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

# To add support for TTYs
source ~/.cache/wal/colors-tty.sh

# Define a function to upload files
upload() { curl -F"file=@$1" https://envs.sh ; }
