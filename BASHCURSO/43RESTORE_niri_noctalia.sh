#!/bin/bash
# restore_niri_setup.sh
# Restores Niri, Noctalia, Kitty, Themes, and Wallpapers from backup

ARCHIVE_NAME="niri_full_backup.tar.gz"

if [ ! -f "$ARCHIVE_NAME" ]; then
  echo "❌ Error: $ARCHIVE_NAME not found in current directory."
  echo "   Please transfer the backup file from your old computer first."
  exit 1
fi

echo "🚀 Starting Restoration..."

# Extract archive
TEMP_DIR="restore_temp_$$"
tar -xzvf "$ARCHIVE_NAME" -C "$TEMP_DIR" --strip-components=1

# 1. Restore Configs
echo "   • Restoring configurations..."
[ -d "$TEMP_DIR/niri" ] && cp -r "$TEMP_DIR/niri" ~/.config/
[ -d "$TEMP_DIR/noctalia" ] && cp -r "$TEMP_DIR/noctalia" ~/.config/
[ -d "$TEMP_DIR/kitty" ] && cp -r "$TEMP_DIR/kitty" ~/.config/

# 2. Restore Themes & Fonts
echo "   • Restoring themes and fonts..."
[ -d "$TEMP_DIR/themes" ] && cp -r "$TEMP_DIR/themes" ~/
[ -d "$TEMP_DIR/icons" ] && cp -r "$TEMP_DIR/icons" ~/
[ -d "$TEMP_DIR/icons_local" ] && cp -r "$TEMP_DIR/icons_local" ~/.local/share/
[ -d "$TEMP_DIR/fonts" ] && cp -r "$TEMP_DIR/fonts" ~/.local/share/

# 3. Restore Wallpapers
echo "   • Restoring wallpapers..."
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

echo "✅ Restoration complete!"
echo "   ⚠️  Please log out and log back in (or reboot) to apply changes."
#Transfer niri_full_backup.tar.gz from your old computer to the new one.
#Save the script above as restore_niri_setup.sh in the same folder as the archive.
#Make executable: chmod +x restore_niri_setup.sh
#Run: ./restore_niri_setup.sh
#Log out and log back in to see your themes and layouts applied.
#Important Notes
#Dependencies: The restore script assumes you have already installed the base software (niri, noctalia, kitty) using your distribution's package manager. It only restores configurations and assets, not the applications themselves.
#Paths: If your wallpapers were stored in a custom location not covered by standard directories, you may need to manually copy that specific folder.
#Config Compatibility: If your new computer uses a different GPU driver or screen resolution, you might need to tweak ~/.config/niri/config.kdl slightly after restoration.
