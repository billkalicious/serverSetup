#!/bin/bash

echo "*****************************************************************"
echo "*****************************************************************"
echo "THIS WILL BACKUP AND RESTORE THE SEVENTEEN SERVER" 
echo "*****************************************************************"
echo "*****************************************************************"
echo ""
read -n1 -r -p "Press any key to continue..." key

# /media/backups/seventeen-20210830-1700.tar.gz
echo -n "Please enter the backup file: "
read backupFilename

echo "--- BACKING UP CURRENT SEVENTEEN TO /media/minecraftservers/seventeen-`date +%Y%m%d-%H%M`/"
cp -r /var/lib/pterodactyl/volumes/d4513c67-0850-4d18-a3a1-ab0c24462760/ /media/minecraftservers/seventeen-`date +%Y%m%d-%H%M`/

echo "--- REMOVING CURRENT SEVENTEEN SERVER"
rm -rf /var/lib/pterodactyl/volumes/d4513c67-0850-4d18-a3a1-ab0c24462760

echo "--- RESTORING SEVENTEEN FROM BACKUP"
echo "tar -xf $backupFilename -C /var/lib/pterodactyl/volumes/"
tar -xf $backupFilename -C /var/lib/pterodactyl/volumes/
