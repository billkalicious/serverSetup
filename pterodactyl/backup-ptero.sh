#!/bin/bash

cd /srv

# echo "Testing to confirm /media/minecraftservers/pterodactyl directory exists..."
# if sudo test -d /opt/ibm/notes; then
# 	echo "$NOTES_VER" > ~/kk-updateversion
# fi

# if ! test -f ~/ibm/notes/data/user.id; then
sudo mkdir -p /media/minecraftservers/pterodactyl

tar zcf /media/minecraftservers/pterodactyl/pterodactyl_panel-`date +%Y%m%d-%H%M`.tar.gz pterodactyl
