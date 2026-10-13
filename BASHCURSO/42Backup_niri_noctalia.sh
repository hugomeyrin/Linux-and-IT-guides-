#!/bin/bash

# backup_niri_setup.sh
# Creates a comprehensive backup of Niri, Noctalia, Kitty, Themes, and Wallpapers

BACKUP_DIR="$HOME/niri_backup_$(date +%Y%m%d_%H%M%S)" # ou le backup va être fait  $HOME  c'est  un alias pour /home/user/  
#et dans le dossier  niri_backup_$( avec la date toujours actualisé) 
ARCHIVE_NAME="niribck_full_backup.tar.gz" #nom de l'archive compréssé  comme sortie du backup 

echo "📦 Starting Niri/Noctalia Backup..."
mkdir -p "$BACKUP_DIR"  #crée le  dossier de backup 

# 1. Configs (Niri, Noctalia, Kitty)
# Copie recursivement les dossiers de configs  (Niri, Noctalia, Kitty) et verifie si ils  sont vides 
# s'ils
echo "   • Copying configurations..."
cp -r ~/.config/niri "$BACKUP_DIR/" 2>/dev/null || echo "     (No niri config found)"
cp -r ~/.config/noctalia "$BACKUP_DIR/" 2>/dev/null || echo "     (No noctalia config found)"
cp -r ~/.config/kitty "$BACKUP_DIR/" 2>/dev/null || echo "     (No kitty config found)"

# 2. Themes & Icons
echo "   • Copying themes and icons..."
cp -r ~/.themes "$BACKUP_DIR/" 2>/dev/null || echo "     (No .themes found)"
cp -r ~/.icons "$BACKUP_DIR/" 2>/dev/null || echo "     (No .icons found)"
cp -r ~/.local/share/icons "$BACKUP_DIR/icons_local" 2>/dev/null || echo "     (No local icons found)"
cp -r ~/.local/share/fonts "$BACKUP_DIR/fonts" 2>/dev/null || echo "     (No local fonts found)"

# 3. Wallpapers (Common locations)
echo "   • Copying wallpapers..."
mkdir -p "$BACKUP_DIR/wallpapers"
if [ -d "$HOME/Pictures/Wallpapers" ]; then
  cp -r "$HOME/Pictures/Wallpapers"/* "$BACKUP_DIR/wallpapers/" 2>/dev/null
fi
if [ -d "$HOME/Images/Wallpapers" ]; then
  cp -r "$HOME/Images/Wallpapers"/* "$BACKUP_DIR/wallpapers/" 2>/dev/null
fi
# Check if wallpaper folder is empty, if so, remove it to save space
if [ -z "$(ls -A "$BACKUP_DIR/wallpapers" 2>/dev/null)" ]; then
  rmdir "$BACKUP_DIR/wallpapers"
fi

# 4. Create Archive
echo "   • Compressing archive..."
cd "$HOME"
tar -czvf "$ARCHIVE_NAME" "$(basename $BACKUP_DIR)"
cp /home/hugo/niribck_full_backup.tar.gz /home/hugo/'kDrive 2'/
# Cleanup temporary folder
rm -rf "$BACKUP_DIR"

echo "✅ Backup complete!"
echo "   File: $HOME/$ARCHIVE_NAME"
echo "   ➡️  Transfer this file to your new computer (via kDrive, USB, or scp)."
