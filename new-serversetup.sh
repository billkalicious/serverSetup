#!/bin/bash

# server guid
#serverPath="192f6c42-38cf-4548-9173-788ed50317c9" # creative world
serverPath="d7fe4e9e-4984-4679-be9c-a36dfad62764" # 1.19

# base vars
#pluginRepo="/home/billkalicious/common_plugins_117"
pluginRepo="/home/billkalicious/common_plugins_119"
pteroVolumes="/var/lib/pterodactyl/volumes/"
fullServerPath="$pteroVolumes$serverPath/"
pluginPath="${fullServerPath}plugins/"
serverProperties="${fullServerPath}server.properties"

bungeeServerPath="${pteroVolumes}/a41bf189-6bea-46da-bafa-653a98d32fdc/"
bungeeConfig="${pteroVolumes}/a41bf189-6bea-46da-bafa-653a98d32fdc/config.yml"

# server specific vars
# iamFile="$fullServerPath/_IAMCREATIVE"
# gameMode="creative"
# levelName="creative_world"
# pvp="false"
# difficulty="peaceful"
# onlineMode="false"
# whiteList="false"
# spawnNPCs="false"
# spawnAnimals="false"
# spawnMonsters="false"
# spawnProtection="0"
# enableCommandBlocks="true"
# viewDistance="20"
# allowNether="false"
# bungeeServerName="builderworld"
# serverAddress="192.168.1.111:25581"
# serverMOTD="Creative Builder World"
# serverRestricted="true"

iamFile="$fullServerPath/_IAM119"
gameMode="survival"
levelName="world"
pvp="true"
difficulty="normal"
onlineMode="false"
whiteList="true"
spawnNPCs="true"
spawnAnimals="true"
spawnMonsters="true"
spawnProtection="0"
enableCommandBlocks="true"
viewDistance="20"
allowNether="true"
bungeeServerName="nineteen"
serverAddress="192.168.1.111:25583"
serverMOTD="Minecraft 1.19 World!"
serverRestricted="false"
levelSeed="-7820269420922620817"

echo "*****************************************************************"
echo "Variables:"
echo "pluginRepo: $pluginRepo"
echo "pteroVolumes: $pteroVolumes"
echo "fullServerPath: $pteroVolumes$serverPath"
echo "pluginPath: $pluginPath"
echo "serverProperties: $serverProperties"
echo "iamFile: $iamFile"
echo "serverPath: $serverPath"
echo "gameMode: $gameMode"
echo "levelName: $levelName"
echo "pvp: $pvp"
echo "difficulty: $difficulty"
echo "onlineMode: $onlineMode"
echo "whiteList: $whiteList"
echo "spawnNPCs: $spawnNPCs"
echo "spawnAnimals: $spawnAnimals"
echo "spawnMonsters: $spawnMonsters"
echo "spawnProtection: $spawnProtection"
echo "enableCommandBlocks: $enableCommandBlocks"
echo "viewDistance: $viewDistance"
echo "allowNether: $allowNether"
echo "bungeeServerName: $bungeeServerName"
echo "serverAddress: $serverAddress"
echo "serverMOTD: $serverMOTD"
echo "serverRestricted: $serverRestricted"
echo "levelSeed: $levelSeed"
echo "*****************************************************************"
echo ""
read -n1 -r -p "Press any key to continue..." key


if ! test -f $iamFile; then
	echo "Creating IAM file..."
	touch $iamFile
	chown pterodactyl:pterodactyl $iamFile
fi

echo "Copying plugins..."
cp -r $pluginRepo/* $pluginPath

echo "Updating server.properties $serverProperties"
sed -i "s/^\(gamemode=\).*$/\1$gameMode/" $serverProperties;
sed -i "s/^\(level-name=\).*$/\1$levelName/" $serverProperties;
sed -i "s/^\(pvp=\).*$/\1$pvp/" $serverProperties;
sed -i "s/^\(difficulty=\).*$/\1$difficulty/" $serverProperties;
sed -i "s/^\(online-mode=\).*$/\1$onlineMode/" $serverProperties;
sed -i "s/^\(white-list=\).*$/\1$whiteList/" $serverProperties;
sed -i "s/^\(spawn-npcs=\).*$/\1$spawnNPCs/" $serverProperties;
sed -i "s/^\(spawn-animals=\).*$/\1$spawnAnimals/" $serverProperties;
sed -i "s/^\(spawn-monsters=\).*$/\1$spawnMonsters/" $serverProperties;
sed -i "s/^\(spawn-protection=\).*$/\1$spawnProtection/" $serverProperties;
sed -i "s/^\(enable-command-block=\).*$/\1$enableCommandBlocks/" $serverProperties;
sed -i "s/^\(view-distance=\).*$/\1$viewDistance/" $serverProperties;
sed -i "s/^\(allow-nether=\).*$/\1$allowNether/" $serverProperties;
sed -i "s/^\(level-seed=\).*$/\1$levelSeed/" $serverProperties;

echo "Checking/adding server to bungee"
if ! sudo grep -q "$bungeeServerName" $bungeeConfig; then
	echo "Not found, adding $bungeeServerName."
	echo "
  $bungeeServerName:
    address: $serverAddress
    motd: $serverMOTD
    restricted: $serverRestricted
" | tee -a $bungeeConfig

	echo ""
	echo "Configuration complete.  Please restart the BungeeCord server."

else
	echo "Server already in bungee config."
fi
