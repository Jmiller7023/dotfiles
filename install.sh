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
yay -S picom-animations-git gnu-free-fonts noto-fonts noto-fonts-cjk nordic-theme-git  noto-fonts-emoji numlockx ttf-jetbrains-mono ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-2048-em-mono  google-chrome --noconfirm

# use pacman for everything else
sudo pacman -S arandr emacs vim nano vscode ffmpeg vlc audacity wireshark-qt firefox git spotify-launcher htop neofetch obs-studio openssh perl pulseaudio pulsemixer python-pip ranger mupdf zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps thunar unzip zip xorg-server xorg-xinit libx11 libxinerama libxft base base-devel --noconfirm
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

if [ -L $HOME/.config/suckless ]; then
  rm -rf $HOME/.config/suckless
fi

if [ -L $HOME/.config/neofetch ]; then
  rm -rf $HOME/.config/neofetch
fi

if [ -L $HOME/.config/kitty ]; then
  rm -rf $HOME/.config/kitty
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