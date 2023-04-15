# Set wallpaper color scheme
wal -R &

# Enable numlock
numlockx on &

# Start dunst
dunst &

# Start dwmblocks
dwmblocks &

# Start clipmenud
clipmenud &

# Start redshift
redshift &

# Start the compositor (picom) with experimental backends enabled
picom --experimental-backends &

# Activate syncthing to sync files
syncthing &

# Ensure that the monitors are being applied properly from arandr config
$HOME/.screenlayout/screen_config.sh

# Run dwm in a loop so that is always restarts on an exit
while true; do
    dwm >/dev/null 2>&1
done