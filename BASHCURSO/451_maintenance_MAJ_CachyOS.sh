#!/bin/bash
set -euo pipefail # it will end your script or any error found 
IFS=$'\n\t'
#
#    -e: exit when a command fails, with some exceptions.
#    -u: treat use of an unset variable as an error.
#    -o pipefail: make a pipeline fail if any command in it fails, not just the last one.
#    IFS=$'\n\t': set word splitting to newlines and tabs, removing spaces from the default separators.
#The $'…' quoting is Bash-style, so this snippet isn’t portable to every POSIX shell. Also, set -e has edge cases; it doesn’t guarantee every failure will terminate the script.
pushd() {       #silent mode 
    command pushd "$@" > /dev/null
}
popd() {
    command popd "$@" > /dev/null
}
#coleurs pour les menus 
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
Backup(){
# Creates a comprehensive backup of Niri, Noctalia, Kitty, Themes, and Wallpapers

BACKUP_DIR="$HOME/niri_backup_$(date +%Y%m%d_%H%M%S)" # ou le backup va être fait  $HOME  c'est  un alias pour /home/user/  
#et dans le dossier  niri_backup_$( avec la date toujours actualisé) 
ARCHIVE_NAME="niribck_full_backup.tar.gz" #nom de l'archive compréssé  comme sortie du backup 
CACHYOS_WALLPAPERS="$HOME/home/hugo/Images/cachyos-wallpapers-develop/usr/share/wallpapers/"
echo "📦 Je commence la sauvegarde de Niri/Noctalia..."
mkdir -p "$BACKUP_DIR"  #crée le  dossier de backup 

# 1. Configs (Niri, Noctalia, Kitty)
# Copie recursivement les dossiers de configs  (Niri, Noctalia, Kitty) et verifie si ils  sont vides 
# s'ils
echo "   • Je copie les configurations..."
for i in $(seq 0 100 10); do
    echo "$i"
    sleep 0.3
done | dialog --gauge "Progression..." 10 50 0
cp -r ~/.config/niri "$BACKUP_DIR/" 2>/dev/null || echo "     (Pas de configuration niri trouvé)"
cp -r ~/.config/noctalia "$BACKUP_DIR/" 2>/dev/null || echo "     (Pas de configuration noctalia trouvé)"
cp -r ~/.config/kitty "$BACKUP_DIR/" 2>/dev/null || echo "     (Pas de configuration kitty trouvé)"

# 2. Themes & Icons
echo "   • Je copie les thémes et icônes..."
cp -r ~/.themes "$BACKUP_DIR/" 2>/dev/null || echo "     (Pas de .themes trouvés)"
cp -r ~/.icons "$BACKUP_DIR/" 2>/dev/null || echo "     (Pas de .icons trouvés)"
cp -r ~/.local/share/icons "$BACKUP_DIR/icons_local" 2>/dev/null || echo "     (Pas D' icons Locaux trouvés)"
cp -r ~/.local/share/fonts "$BACKUP_DIR/fonts" 2>/dev/null || echo "     (Pas de fonts Locaux found)"

# 3. Wallpapers (Common locations)
echo "   • Je Copie des Fonds D'écran..."
mkdir -p "$BACKUP_DIR/wallpapers"
if [ -d "$HOME/Pictures/Wallpapers" ]; then
  cp -r "$HOME/Pictures/Wallpapers"/* "$BACKUP_DIR/wallpapers/" 2>/dev/null
  cp -r "$CACHY_OSWALLPAPERS"/* "$BACKUP_DIR/wallpapers/" 2>/dev/null
fi
if [ -d "$HOME/Images/Wallpapers" ]; then
  cp -r "$HOME/Images/Wallpapers"/* "$BACKUP_DIR/wallpapers/" 2>/dev/null
fi
# Check if wallpaper folder is empty, if so, remove it to save space
if [ -z "$(ls -A "$BACKUP_DIR/wallpapers" 2>/dev/null)" ]; then
  rmdir "$BACKUP_DIR/wallpapers"
fi

# 4. Create Archive
echo "   • Archive en compression..."
cd "$HOME"
tar -czvf "$ARCHIVE_NAME" "$(basename $BACKUP_DIR)"
cp /home/hugo/niribck_full_backup.tar.gz /home/hugo/'kDrive 2'/
# Cleanup temporary folder
rm -rf "$BACKUP_DIR"

echo "✅ Sauvegarde Achevée!"
echo "   File: $HOME/$ARCHIVE_NAME"
echo "   ➡️  Transférez ce fichiez vers votre nouvel ordinateur(via kDrive, USB, or scp)."
}
Restore(){

ARCHIVE_NAME="niribck_full_backup.tar.gz"
  echo " Avez vous téléchargé l'archive de sauvegarde et êtes-vous sur le bon dossier?"
if [ ! -f "$ARCHIVE_NAME" ]; then
  echo "❌ Erreur: $ARCHIVE_NAME non trouvé dans le répertoire actuel."
  echo "   S'il vous plaît transférez d'abord le fichier de sauvegarde depuis votre ordinateur d'avant."
  exit 1
fi
echo 
echo "🚀 Restauration à Commencée..."

# Extract archive
TEMP_DIR="restore_temp_$$"
tar -xzvf "$ARCHIVE_NAME" -C "$TEMP_DIR" --strip-components=1

# 1. Restore Configs
echo "   • À Restaurer les Configurations..."
[ -d "$TEMP_DIR/niri" ] && cp -r "$TEMP_DIR/niri" ~/.config/
[ -d "$TEMP_DIR/noctalia" ] && cp -r "$TEMP_DIR/noctalia" ~/.config/
[ -d "$TEMP_DIR/kitty" ] && cp -r "$TEMP_DIR/kitty" ~/.config/

# 2. Restore Themes & Fonts
echo "   • À Restaurer les thèmes et fonts..."
[ -d "$TEMP_DIR/themes" ] && cp -r "$TEMP_DIR/themes" ~/
[ -d "$TEMP_DIR/icons" ] && cp -r "$TEMP_DIR/icons" ~/
[ -d "$TEMP_DIR/icons_local" ] && cp -r "$TEMP_DIR/icons_local" ~/.local/share/
[ -d "$TEMP_DIR/fonts" ] && cp -r "$TEMP_DIR/fonts" ~/.local/share/

# 3. Restore Wallpapers
echo "   • À Restaurer Les Fonds D'écrans..."
if [ ! -d "$TEMP_DIR/wallpapers" ]; then
  mkdir -p "$HOME/Pictures/Wallpapers"
  cp -r "$TEMP_DIR/wallpapers"/* "$HOME/Pictures/Wallpapers/" 2>/dev/null
fi

# 4. Fix Permissions & Cache
echo "   • Fixing permissions and updating caches..."
# Make scripts executable
find ~/.config/niri -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null
find ~/.config/niri -type f -name "*.kdl" -exec chmod 644 {} \; 2>/dev/null

# Update font cache
if [ -d ~/.local/share/fonts ]; then
  fc-cache -fv >/dev/null 2>&1
fi

# Cleanup
rm -rf "$TEMP_DIR"

echo "✅ Restoration compléte!"
echo "   ⚠️  S'il vous plaît déconnectez-vous de la Session et reconnectez à nouveau, si non rédemarrez votre pc."
#Transfer niri_full_backup.tar.gz from your old computer to the new one.
#Save the script above as restore_niri_setup.sh in the same folder as the archive.
#Make executable: chmod +x restore_niri_setup.sh
#Run: ./restore_niri_setup.sh
#Log out and log back in to see your themes and layouts applied.
#Important Notes
#Dependencies: The restore script assumes you have already installed the base software (niri, noctalia, kitty) using your distribution's package manager. It only restores configurations and assets, not the applications themselves.
#Paths: If your wallpapers were stored in a custom location not covered by standard directories, you may need to manually copy that specific folder.
#Config Compatibility: If your new computer uses a different GPU driver or screen resolution, you might need to tweak ~/.config/niri/config.kdl slightly after restoration.
}
programmes_multi(){
qt5-svg 
qt5-x11extras 
mbedtls 
pipewire 
cmake 
git 
libfdk-aac 
swig 
qt5-wayland 
sndio
a52dec 
libdvbpsi 
libdca 
libmatroska 
taglib 
libmpcdec 
faad2 
libmad 
libmpeg2 
libtar 
libupnp 
libixml.so 
libupnp.so 
libplacebo 
wayland-protocols 
live-media 
libdc1394 
libcaca 
libgme 
xosd 
twolame 
aalib 
libmtp 
libupnp 
libmicrodns 
libdvdcss 
smbclient 
vcdimager 
protobuf 
libnfs 
mpg123 
libdvdread 
libdvdnav 
libshout 
zvbi 
libkate 
libtiger 
sdl_image 
lirc 
libgoom2 
projectm 
chromaprint 
aribb24 
aribb25 
pcsclite 
lua51
kdenlive
krita
inkscape
flatpak 
audacity
lmms
mixxx
}
Steam_Niri() {
    echo "Selectionnez la version 0.8.1 dans le menu et rebootez la machine, le script le fera mais choisissez le"
    xwayland-satellite --version 2>&1 || pacman -Qs xwayland-satellite
    sudo pacman -Syu downgrade
    sudo downgrade xwayland-satellite
    cat /etc/pacman.conf
    sudo sed -i 's/IgnorePkg = xwayland-satellite/IgnorePkg = xwayland-satellite/' /etc/pacman.conf
    read -r -p "Voulez redémarrer : O/N " rep
    if [[ $rep == "O"  ]]; then
    sudo reboot
    else [[ $rep == "N" ]];
    exit 
    fi
}
Multimedia() {
    for programme in ${programmes_multi[@]}; do 
    sudo pacman -S $programme -y 
    sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub org.gimp.GIMP
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/en/apps/com.obsproject.Studio 
    flatpak install flathub -y com.obsproject.Studio
   done  
}
Performance(){
    echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf #tee envoi le fichier de text chez echo vers le fichier sysctl.conf
    sudo sysctl -p  #Recharge /etc/sysctl.conf
    sudo pacman -S cpupower-gui
    sudo cpupower frequency-set -g performance
    sudo pacman -S gamemode
    gamemoded -t
}
Drivers_Gaming(){
    lspci | grep -i vga
    read -r -p "[INFO] Quel est votre carte graphique?(amd|nvidia|intel) " graphique
    if [[ "$graphique" == "amd" ]]; then 
    sudo pacman -S mesa vulkan-radeon lib32-mesa lib32-vulkan-radeon
    vulkaninfo --summary
    elif [[ "$graphique" == "nvidia" ]]; then
    sudo pacman -Syu nvidia-utils lib32-nvidia-utils vulkan-tools
    vulkaninfo --summary
    elif [[ "$graphique" == "intel" ]]; then
    sudo pacman -Syu vulkan-intel lib32-vulkan-intel vulkan-tools
    vulkaninfo --summary
    else
    echo "Valeur inconnue : $graphique (utilise amd, nvidia ou intel)"
    exit 1
    fi 
    sudo pacman -S steam
    sudo pacman -S gamemode wine lutris
    sudo flatpak install flathub com.heroicgameslauncher.hgl
}
Clean(){
    sudo pacman -Qdtq 
    sudo pacman -Sc 
    #sudo systemctl disable --now systemd-tmpfiles-clean.timer
    #sudo systemctl stop systemd-tmpfiles-clean 
    sudo rm -rf /tmp/* 2>&1 | echo "$?"
    #sudo systemctl start systemd-tmpfiles-clean 
}
InstallationDate(){
        sudo stat /
}
Update(){
    sudo pacman -S dialog 2>&1
    sudo pacman -S flatpak 2>&1
    sudo pacman -Syu 2>&1
    echo "$?"
}
FingerPrint(){
    sudo pacman -Sy
    sudo pacman -S fprintd libpam-fprintd
    fprintd-enroll
}
Upgrade(){
    sudo pacman -Syuu 2>&1
    echo "$?"
}
Checkpkg() {
    echo "Liste Flatpak Installés:"
    flatpak list --app
    echo "Liste Packets Installés:"
    pacman -Qe 
    echo "Liste Paquets disponible sur toutes les depôts"
    pacman -Ss editor
     read -r -p "[INFO] Installer un logiciel (cherchez s'il existe sur cachyos et tapez en minuscules!): " programme
    if pacman -Qi "$programme" &>/dev/null; then  # &> est un raccourci bash pour > fichier 2>&1 error  et sortie 
        echo "Logiciel déjà installé"
    else
        sudo pacman -Syu "$programme"
    fi
}
while true; do
  echo  -e ${GREEN}"* =========================== Gestion et Maintenance CachyOS ===========================* "
  echo              "* 1) Mise à jour                                                                        *"
  echo              "* 2) Mise à Niveau                                                                      *"
  echo              "* 3) Nettoyer son Cache                                                                 *"
  echo              "* 4) Installer et configurer lecteur de impression digitale       (laptop)              *"
  echo              "* 5) Performance                                                                        *"
  echo              "* 6) Logiciels pour multimédia                                                          *"
  echo              "* 7) Pilotes Graphiques et Aplications pour le Gaming  (selon votre matériel)           *"
  echo              "* 8) Sauvegarde (Niri / Noctalia / Configs)                                             *"
  echo              "* 9) Restaurer (Niri / Noctalia / Configs )                                             *"
  echo              "* 10) Corriger Probleme Menus Steam avec X11 vers Xwayland   (cachyos niri et noctalia) *"
  echo              "* 11) Installer Prog- vérification si les logiciels sont installés / sinon installe les *"
  echo              "* 12) Date D'Installation                                                               *"
  echo -e ${GREEN}"* *************************************************************************************** "  
  echo -e ${RED} "*                                       0) Sortir                                        * "   
  echo -e ${GREEN}"* ================================= Par Vitor Barbosa ==================================* "
  read -r -p "Quel est ton choix  " choix
  # Prompt securely into variable
  # Validate credentials
  # printf '%s\n' "$SUDO_PASS" | sudo -S -v -p '' # || {
  #echo "Invalid password" >&2
  #unset SUDO_PASS
  #exit 1 }
  case $choix in
  1)
    Update 
    ;;
  2)
    Upgrade  
    ;;
  3)
    Clean
    ;;
  4)
    FingerPrint
    ;;
  5)
    Performance
    ;;
  6)
    Multimedia 
    ;;
  7)
    Drivers_Gaming
    ;;
  8)
    Backup
    ;;
  9)
    Restore
    ;;
  10)
    Steam_Niri
     ;;
  11)
    Checkpkg
    ;;
  12)
    InstallationDate
   ;;
  *)
    echo "Au Revoir"
    exit
    ;;
  esac
done
