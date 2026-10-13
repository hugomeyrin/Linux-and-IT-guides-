#!/bin/bash
#  Backup Script il fonctionne finalement 
echo "%%%%%%%%% Backup Script %%%%%%%%%"
read -p "Peut tu me indiquer le dossier a sauvegarder: " source_dir
source_dir=$source_dir 
read -p "Peut tu me indiquer le dossier de destination: " dest_dir
dest_dir=$dest_dir

#Create a time stamp 
TIMESTAMP=$(date)
backup_dir="$dest_dir/backup_$TIMESTAMP"


#Create a destination directory if doesn't exists
if  [[ -z $backup_dir ]]; then  
sudo mkdir -p "$backup_dir"
else 
echo "le dossier a pas pu être crèè"
fi

#Perform the backup using rsync 

echo "...Backing up files from $source_dir to $backup_dir..."
sudo rsync -avxHAXS --exclude={/dev/,/proc/,/sys/,/run/,/tmp/,/mnt/,/media/,/lost-found/} --progress "$source_dir" "$dest_dir"
#this is a backup script
 if [[ $? -eq 0 ]]; then # ( le dernier variable executé ( chiffre 0 ok)
  echo "Backup Completed Successfully" 
else 
  echo "Backup failed!"
fi 
echo "%%%%%%%% END %%%%%%%%%"
