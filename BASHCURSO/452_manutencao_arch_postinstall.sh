#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
while true; do
  echo "*=========== Actualizações Arch / Derivados ================= *"
  echo "* 1) Actualizar                                               *"
  echo "* 2) Actualizar Distro Completa                               *"
  echo "* 3) Limpar o Cache                                           *"
  echo "* 4) Instalar e Configurar suas impressões digitais           *"
  echo "* 5) Performance                                              *"
  echo "* 6) Programas para Multimédia e Criação de conteúdo          *"
  echo "* 7) Preparação para Jogos                                    *"
  echo "* 8) Data de Instalação                                       *"
  echo "* 9) Sair                                                     *"
  echo "* 10) Resolver o problema de Steam no CachyOs - Niri/Noctalia *"
  echo "*================= Feito por Vitor Barbosa ================== *"
  read -r -p "Qual é sua escolha  :" choix
  # Prompt securely into variable
  # Validate credentials
  # printf '%s\n' "$SUDO_PASS" | sudo -S -v -p '' # || {
  #echo "Invalid password" >&2
  #unset SUDO_PASS
  #exit 1 }
  case $choix in
  1)
    sudo pacman -S
    ;;
  2)
    sudo pacman -Syu
    ;;
  3)
    sudo pacman -Qdtq
    sudo pacman -Sc
    sudo systemctl stop systemd-tmpfiles-clean
    sudo rm -rf /tmp/*
    sudo systemctl start systemd-tmpfiles-clean
    ;;
  4)
    sudo pacman -Sy
    sudo pacman -S fprintd libpam-fprintd
    fprintd-enroll
    ;;
  5)
    echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p
    sudo pacman -S cpupower-gui
    sudo cpupower frequency-set -g performance
    sudo pacman -S gamemode
    gamemoded -t
    ;;
  6)
    sudo pacman -S qt5-svg qt5-x11extras mbedtls pipewire cmake git libfdk-aac swig qt5-wayland sndio
    sudo pacman -S a52dec libdvbpsi libdca libmatroska taglib libmpcdec faad2 libmad libmpeg2 libtar libupnp libixml.so libupnp.so libplacebo wayland-protocols live-media libdc1394 libcaca libgme xosd twolame aalib libmtp libupnp libmicrodns libdvdcss smbclient vcdimager protobuf libnfs mpg123 libdvdread libdvdnav libshout zvbi libkate libtiger sdl_image lirc libgoom2 projectm chromaprint aribb24 aribb25 pcsclite lua51
    echo "en cours d'installation OBS $USER"
    #sudo add-apt-repository ppa:obsproject/obs-studio
    echo "...Downloading OBS"
    wget https://aur.archlinux.org/cgit/aur.git/snapshot/obs-studio-browser.tar.gz
    #Now, lets install it!
    tar xvzf obs-studio-browser.tar.gz
    cd obs-studio-browser
    makepkg -i
    sudo pacman -Syu
    sudo pacman -S kdenlive
    sudo pacman -S inkscape
    sudo -Sy flatpak
    sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub org.gimp.GIMP
    sudo pacman -S krita
    sudo pacman -S audacity
    sudo pacman -S lmms
    sudo pacman -S mixxx
    ;;
  7)
    read -r -p "VULKAN Qual é sua carta grafica? " graphique
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
    sudo pacman -S gamemode vulkan-utils wine lutris
    ;;
  8)
    sudo stat /
    ;;
  9)
    exit
    ;;
  10)
    echo "Selecione a versão 0.8.1 no menu e reinicie o seu pc"
    xwayland-satellite --version 2>&1 || pacman -Qs xwayland-satellite
    sudo pacman -Syu downgrade
    sudo downgrade xwayland-satellite
    cat /etc/pacman.conf
    sudo sed -i 's/IgnorePkg = xwayland-satellite/IgnorePkg = xwayland-satellite/' /etc/pacman.conf
    read -r -p "Quer Reiniciar o pc? : O/N " rep
    if [[ $rep == "O"  ]]; then
    sudo reboot
    else [[ $rep == "N" ]];
    exit 
    fi
     ;;  
  *)
    echo "Até Breve"
    exit
    ;;
  esac
done