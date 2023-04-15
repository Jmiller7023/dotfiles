#!/bin/bash
dotfiles_repo=$(pwd)
clear

echo "Installing yay..."
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si 
sleep 1 && clear

echo "Installing programs..."

# use yay to get the fonts and AUR packages
yay -S anki cava tty-clock-git ttf-kanjistrokeorders protonvpn-cli qbittorrent mecab-ipadic kakasi picom-animations-git slop devour gnu-free-fonts noto-fonts noto-fonts-cjk nordic-theme-git  noto-fonts-emoji numlockx ttf-jetbrains-mono ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-2048-em-mono  google-chrome --noconfirm
sudo pywalfox install
sleep 1 && clear

# use pacman for everything else
sudo pacman -S arandr redshift flameshot qalculate-gtk tmux syncthing network-manager-applet tree bluez  bluez-utils cifs-utils clipmenu cmus dbus dunst xclip webkit2gtk sxiv autoconf-archive yt-dlp iniparser alsa-lib ncurses exa fftw mplayer mpv discord emacs vim nano vscode python-pywal ffmpegthumbnailer ffmpeg vlc audacity wireshark-qt firefox git spotify-launcher htop neofetch obs-studio openssh perl pulseaudio  pulseaudio-bluetooth pulsemixer python-pip ranger mupdf zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps zathura thunar unzip zip xorg-server xorg-xinit libx11 libxinerama libxft base base-devel --noconfirm
sleep 1 && clear

# Install Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
if [ -L $HOME/.config/zsh ]; then
  rm $HOME/.config/zsh
fi
ln -sf $dotfiles_repo/.config/zsh $HOME/.config/zsh 

if [ -d ~/.oh-my-zsh ]; then
    mv ~/.oh-my-zsh ~/.config/
fi

echo "Organizing dotfiles..."
echo ""

[ ! -d $HOME/.config ] && mkdir $HOME/.config
[ ! -d $HOME/.local ] && mkdir $HOME/.local
[ ! -d $HOME/.local/bin ] && mkdir $HOME/.local/bin
[ ! -d $HOME/.screenlayout ] && mkdir $HOME/.screenlayout
[ ! -d $HOME/.icons ] && mkdir $HOME/.icons

# Extracting icon sets
echo "Loading in icon sets..."
for FILE in icons/*; 
do 
tar -xvf $FILE --directory=$HOME/.icons/
done

# Remove original directories and replace them with symbolic links
if [ -L $HOME/.config/suckless ]; then
  rm -rf $HOME/.config/suckless
fi
ln -sf $dotfiles_repo/suckless $HOME/.config/suckless

if [ -L $HOME/.config/kitty ]; then
  rm -rf $HOME/.config/kitty
fi
ln -sf $dotfiles_repo/.config/kitty $HOME/.config/kitty

if [ -L $HOME/.config/picom ]; then
  rm -rf $HOME/.config/picom
fi
ln -sf $dotfiles_repo/.config/picom $HOME/.config/picom

if [ -L $HOME/.config/redshift ]; then
  rm -rf $HOME/.config/redshift
fi
ln -sf $dotfiles_repo/.config/redshift $HOME/.config/redshift

if [ -L $HOME/.config/mpv ]; then
  rm -rf $HOME/.config/mpv
fi
ln -sf $dotfiles_repo/.config/mpv $HOME/.config/mpv

if [ -L $HOME/.config/neofetch ]; then
  rm -rf $HOME/.config/neofetch
fi
ln -sf $dotfiles_repo/.config/neofetch $HOME/.config/neofetch

if [ -L $HOME/.config/sxiv ]; then
  rm -rf $HOME/.config/sxiv
fi
ln -sf $dotfiles_repo/.config/sxiv $HOME/.config/sxiv

if [ -L $HOME/.config/ranger ]; then
  rm -rf $HOME/.config/ranger
fi
ln -sf $dotfiles_repo/.config/ranger $HOME/.config/ranger

if [ -L $HOME/.config/zathura ]; then
  rm -rf $HOME/.config/zathura
fi
ln -sf $dotfiles_repo/.config/zathura $HOME/.config/zathura

if [ -L $HOME/.config/cmus ]; then
  rm -rf $HOME/.config/cmus
fi
ln -sf $dotfiles_repo/.config/cmus $HOME/.config/cmus

# These are special as pywal generates templates for them in a new location
if [ -L $HOME/.config/wal ]; then
  rm -rf $HOME/.config/wal
fi
ln -sf $dotfiles_repo/.config/wal $HOME/.config/wal

if [ -L $HOME/.config/dunst ]; then
  rm -rf $HOME/.config/dunst
  mkdir $HOME/.config/dunst
fi
ln -sf $HOME/.cache/wal/dunstrc $HOME/.config/dunst/dunstrc

if [ -L $HOME/.config/flameshot ]; then
  rm -rf $HOME/.config/flameshot
  mkdir $HOME/.config/flameshot
fi
ln -sf $HOME/.cache/wal/flameshot.ini $HOME/.config/flameshot/flameshot.ini

if [ -L $HOME/.config/cava ]; then
  rm -rf $HOME/.config/cava
  mkdir $HOME/.config/cava
fi
ln -sf $HOME/.cache/wal/config $HOME/.config/cava/config

echo "generating symbolic links"
ln -sf $dotfiles_repo/.zshenv $HOME/.zshenv
ln -sf $dotfiles_repo/.screenlayout/screen_config.sh $HOME/.screenlayout/screen_config.sh
ln -sf $dotfiles_repo/.Xresources $HOME/.Xresources
ln -sf $dotfiles_repo/.bashprofile $HOME/.bashprofile
ln -sf $dotfiles_repo/.bashrc $HOME/.bashrc
ln -sf $dotfiles_repo/.xinitrc $HOME/.xinitrc

echo "Setting /etc/pulse/default.pa to auto-reconnect to bluetosoth"
sudo echo "load-module module-switch-on-connect" > /etc/pulse/default.pa

echo "Installing suckless programs..."
cd $dotfiles_repo/suckless/dwm && sudo make clean install && mv -f config.h config.def.h
cd $dotfiles_repo/suckless/st && sudo make clean install && mv -f config.h config.def.h
cd $dotfiles_repo/suckless/dmenu && sudo make clean install && mv -f config.h config.def.h

echo "list of other tasks to get set back up"
echo "In firefox go to about:config and create a variable ui.textScaleFactor and set it to 200"
echo "Gain push access to github https://github.com/settings/tokens"
echo "Go to server_ip:8384 to obtain shared folders from Syncthing"
echo "Adjust theme with lxappearance (Theme Nordic) (Icon Infinity-Dark-Icons) (default font System-ui size:26)"
echo "Adjust scaling in thunar, spotify (ctrl_+ / ctrl_-), etc."
echo -e "Mount network driver automatically by adding this to end of /etc/fstab:\n//SERVER_IP/DRIVE_NAME /mnt/server/ cifs credentials=/root/.smbServer,uid=1000 0 0"
echo -e "/root/.smbServer will contain two lines\nusername=USERNAME\npassword=PASSWORD. use chmod 700 to protect it"
echo "Set up anki and load yomichan dictionaries. 200% UI scaling plugins ankiconnect=2055492159"
echo "Install the extensions GlassIT-VSC and Wal Theme for Visual Studio Code"