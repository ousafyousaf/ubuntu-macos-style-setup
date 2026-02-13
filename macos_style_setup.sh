#!/bin/bash

echo "🎯 Starting MacOS Style Setup for Ubuntu (GNOME) 🎯"

# -----------------------------
# Update & install dependencies
# -----------------------------
echo "🔄 Updating system..."
sudo apt update -y
sudo apt install -y gnome-tweaks gnome-shell-extensions curl git unzip fonts-powerline plank xdotool wmctrl

# -----------------------------
# Enable GNOME extensions
# -----------------------------
echo "🔧 Enabling GNOME Extensions..."
gnome-extensions enable dash-to-dock@micxgx.gmail.com || true
gnome-extensions enable just-perfection@jderose9.github.com || true
gnome-extensions enable blur-my-shell@aunetx || true

# -----------------------------
# Install Dash to Dock & Plank dock
# -----------------------------
mkdir -p ~/gnome-extensions
git clone https://github.com/micheleg/dash-to-dock.git ~/gnome-extensions/dash-to-dock
cd ~/gnome-extensions/dash-to-dock
make install
cd ~
gnome-extensions enable dash-to-dock@micxgx.gmail.com
sudo apt install -y plank

# -----------------------------
# Mac Theme (WhiteSur)
# -----------------------------
mkdir -p ~/.themes ~/.icons
cd ~
curl -Lo WhiteSur-gtk.zip https://github.com/vinceliuice/WhiteSur-gtk-theme/archive/refs/heads/master.zip
unzip -o WhiteSur-gtk.zip -d ~/.themes
rm WhiteSur-gtk.zip

curl -Lo WhiteSur-icons.zip https://github.com/vinceliuice/WhiteSur-icon-theme/archive/refs/heads/master.zip
unzip -o WhiteSur-icons.zip -d ~/.icons
rm WhiteSur-icons.zip

curl -Lo WhiteSur-cursor.zip https://github.com/vinceliuice/WhiteSur-cursors/archive/refs/heads/master.zip
unzip -o WhiteSur-cursor.zip -d ~/.icons
rm WhiteSur-cursor.zip

# -----------------------------
# Fonts
# -----------------------------
sudo apt install -y fonts-cantarell fonts-inter

# -----------------------------
# GNOME Tweaks Settings
# -----------------------------
gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-icon-theme-master'
gsettings set org.gnome.desktop.interface cursor-theme 'WhiteSur-cursors-master'
gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-gtk-theme-master'

# Dash to Dock
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide true
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 48
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false

# Just Perfection
gsettings set org.gnome.shell.extensions.just-perfection activities-visible false
gsettings set org.gnome.shell.extensions.just-perfection top-bar-padding 2
gsettings set org.gnome.shell.extensions.just-perfection center-clock true

# Blur My Shell
gsettings set org.gnome.shell.extensions.blur-my-shell blur-enabled true

# Plank autostart
mkdir -p ~/.config/autostart
cat << 'EOF' > ~/.config/autostart/plank.desktop
[Desktop Entry]
Type=Application
Exec=plank
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Plank
Comment=Mac Style Dock
EOF

echo "🎉 MacOS style setup complete!"
echo "💡 Logout / Reboot recommended for full effect"
