#!/bin/bash
flatpak install fedora-testing org.fedoraproject.Platform/x86_64/f36
flatpak install flathub net.davidotek.pupgui2
sudo dnf install lutris
sudo dnf install steam
sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/36/winehq.repo
sudo dnf install winehq-devel
sudo dnf config-manager --set-enabled rpmfusion-nonfree-nvidia-driver
sudo dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda
flatpak install flathub com.discordapp.Discord
flatpak install flathub com.obsproject.Studio
sudo dnf install q4wine
echo "success"
