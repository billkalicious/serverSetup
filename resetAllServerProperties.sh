#!/bin/bash

cd /var/lib/pterodactyl/volumes/

# server specific vars
onlineMode="false"
enableCommandBlocks="true"
viewDistance="20"
connectionThrottle="-1"
bungeeMode="true"

echo "*****************************************************************"
echo "Variables:"
#echo "pteroVolumes: $pteroVolumes"
#echo "fullServerPath: $pteroVolumes$serverPath"
#echo "serverProperties: $serverProperties"
echo "onlineMode: $onlineMode"
echo "enableCommandBlocks: $enableCommandBlocks"
echo "viewDistance: $viewDistance"
echo "connectionThrottle: $connectionThrottle"
echo "bungeeMode: $bungeeMode"
#echo "bukkit: $bukkit" 
#echo "spigot: $spigot" 
echo "*****************************************************************"
echo ""
read -n1 -r -p "Press any key to continue..." key


for D in *; do
    if [ -d "${D}" ]; then
        echo "${D}"   # your processing here

		serverPath=${D}

		# base vars
		pteroVolumes="/var/lib/pterodactyl/volumes/"
		fullServerPath="$pteroVolumes$serverPath/"
		serverProperties="${fullServerPath}server.properties"
		bukkit="${fullServerPath}bukkit.yml"
		spigot="${fullServerPath}spigot.yml"

		echo "*******************************************************"
		echo "Now updating server guid ${D}"
		echo "*******************************************************"
		echo ""
		echo "Updating server.properties $serverProperties"
		sed -i "s/^\(online-mode=\).*$/\1$onlineMode/" $serverProperties;
		sed -i "s/^\(enable-command-block=\).*$/\1$enableCommandBlocks/" $serverProperties;
		sed -i "s/^\(view-distance=\).*$/\1$viewDistance/" $serverProperties;

		echo "Updating bukkit.yml $bukkit"
		sed -i "s/^\(.*connection-throttle:\s\).*$/\1$connectionThrottle/" $bukkit;

		echo "Updating spigot.yml $spigot"
		sed -i "s/^\(.*bungeecord:\s\).*$/\1$bungeeMode/" $spigot;
    fi
done
