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
yay -S anki cava ttf-kanjistrokeorders mecab-ipadic kakasi picom-animations-git gnu-free-fonts noto-fonts noto-fonts-cjk nordic-theme-git  noto-fonts-emoji numlockx ttf-jetbrains-mono ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-2048-em-mono  google-chrome --noconfirm

# use pacman for everything else
sudo pacman -S arandr bluez  bluez-utils cifs-utils autoconf-archive iniparser alsa-lib ncurses fftw mplayer mpv discord emacs vim nano vscode python-pywal ffmpeg vlc audacity wireshark-qt firefox git spotify-launcher htop neofetch obs-studio openssh perl pulseaudio  pulseaudio-bluetooth pulsemixer python-pip ranger mupdf zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps thunar unzip zip xorg-server xorg-xinit libx11 libxinerama libxft base base-devel --noconfirm
sleep 1 && clear

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

if [ -L $HOME/.config/neofetch ]; then
  rm -rf $HOME/.config/neofetch
fi

if [ -L $HOME/.config/kitty ]; then
  rm -rf $HOME/.config/kitty
fi

if [ -L $HOME/.config/picom ]; then
  rm -rf $HOME/.config/picom
fi

echo "generating symbolic links"
ln -sf $dotfiles_repo/.screenlayout/screen_config.sh $HOME/.screenlayout/screen_config.sh
ln -sf $dotfiles_repo/.Xresources $HOME/.Xresources
ln -sf $dotfiles_repo/.bashprofile $HOME/.bashprofile
ln -sf $dotfiles_repo/.bashrc $HOME/.bashrc
ln -sf $dotfiles_repo/.xinitrc $HOME/.xinitrc
ln -sf $dotfiles_repo/suckless $HOME/.config/suckless
ln -sf $dotfiles_repo/.config/kitty $HOME/.config/kitty
ln -sf $dotfiles_repo/.config/neofetch $HOME/.config/neofetch
ln -sf $dotfiles_repo/.config/picom $HOME/.config/picom
ln -sf $dotfiles_repo/dotfiles/.config/wal $HOME/.config/wal
ln -sf $HOME/.cache/wal/config $HOME/.config/cava/config

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
echo -e "Mount netork driver automatically by adding this to end of /etc/fstab:\n//SERVER_IP/DRIVE_NAME /mnt/server/ cifs credentials=/root/.smbServer,uid=1000 0 0"
echo -e "/root/.smbServer will contain two lines\nusername=USERNAME\npassword=PASSWORD. use chmod 700 to protect it"
echo "Set up anki and load yomichan dictionaries. 200% UI scaling plugins ankiconnect=2055492159"
echo "Install the extensions GlassIT-VSC and Wal Theme for Visual Studio Code"