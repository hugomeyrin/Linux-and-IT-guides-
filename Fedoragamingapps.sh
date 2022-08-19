#!/bin/bash
flatpak install fedora-testing org.fedoraproject.Platform/x86_64/f36
flatpak install flathub net.davidotek.pupgui2
sudo dnf install snapd
sudo ln -s /var/lib/snapd/snap /snap
echo "choose install gamer apps"
echo "Chose version:
1) lutris
2) steam
3) Wine
4) nvidia drivers
5) discord
6) obdstudio
7) nextcloud-client-sync
8) teams
9) Upgrade
10) Snap support apps add and linux outlook client
11) kde desktop
12) system update
13) Reboot after kde desktop  (mandatory)
14) Backup
15) Visual Studio
16) Telegram/Chrome/okular pdf reader / Heroic-Games-Launcher (epic games store)/ Firefox /flameshot (advanced screen shot)
17) Exit
18) Printer Driver HP's Models
-> "
read option

# options
if [ "$option" == "1" ]; then
sudo dnf install lutris
fi
if [ "$option" == "2" ]; then
sudo dnf install steam
fi
if [ "$option" == "3" ]; then
sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/36/winehq.repo
sudo dnf install winehq-devel
sudo dnf install q4wine
fi
if [ "$option" == "4" ]; then
sudo dnf config-manager --set-enabled rpmfusion-nonfree-nvidia-driver
sudo dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda
fi
if [ "$option" == "5" ]; then
flatpak install flathub com.discordapp.Discord
fi
if [ "$option" == "6" ]; then
flatpak install flathub com.obsproject.Studio
fi
if [ "$option" == "7" ]; then
sudo dnf install nextcloud-client
fi
if [ "$option" == "8" ]; then
sudo tee /etc/yum.repos.d/ms-teams.repo<<EOF
[Teams]
name=teams
baseurl=https://packages.microsoft.com/yumrepos/ms-teams
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
sudo dnf install teams -y
fi
if [ "$option" == "9" ]; then
sudo dnf upgrade --refresh
fi
if [ "$option" == "10" ]; then
sudo dnf install snapd
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install prospect-mail
fi
if [ "$option" == "11" ]; then
sudo dnf groupinstall -y "KDE Plasma Workspaces"
fi
if [ "$option" == "12" ]; then
sudo dnf update
fi
if [ "$option" == "13" ]; then
sudo reboot
fi
if [ "$option" == "14" ]; then
sudo dnf cache 
sudo dnf install timeshift.x86_64
fi
if [ "$option" == "15" ]; then
sudo dnf upgrade --refresh
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
printf "[vscode]\nname=packages.microsoft.com\nbaseurl=https://packages.microsoft.com/yumrepos/vscode/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscode.repo
sudo dnf install code -y
sudo dnf update --refresh
fi
if [ "$option" == "16" ]; then
sudo dnf install telegram -y
sudo dnf install google-chrome-stable
sudo dnf install okular -y
flatpak install flathub com.heroicgameslauncher.hgl
flatpak install flathub org.mozilla.firefox 
sudo snap install flameshot
fi
if [ "$option" == "17" ]; then
exit
fi
if [ "$option" == "18" ]; then
sudo dnf install hplip
fi
echo "success"
