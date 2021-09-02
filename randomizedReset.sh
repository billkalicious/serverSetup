#!/bin/bash

# server guid
serverPath="e3115ba8-184b-45ef-9505-2b217c4a4f37"

# base vars
pluginRepo="/home/billkalicious/common_plugins_117"
pteroVolumes="/var/lib/pterodactyl/volumes/"
fullServerPath="$pteroVolumes$serverPath/"
pluginPath="${fullServerPath}plugins/"
datapackRepo="randomizedDPs/"
randomDP="$fullServerPath${datapackRepo}random_loot_-185455879272423.zip"
#randomDP="random_loot_-1854558792724972500.zip"
#randomDP="random_loot_-185455879272497.zip"
newDataPack="$fullServerPath$datapackRepo$randomDP"
serverProperties="${fullServerPath}server.properties"
bukkit="${fullServerPath}bukkit.yml"
spigot="${fullServerPath}spigot.yml"
worldFolder="${fullServerPath}world"
datapackFolder="${fullServerPath}world/datapacks"

# server specific vars
iamFile="${fullServerPath}_IAMRANDOMIZED"
gameMode="survival"
levelName="world"
pvp="false"
difficulty="normal"
onlineMode="false"
whiteList="false"
spawnNPCs="true"
spawnAnimals="true"
spawnMonsters="true"
spawnProtection="0"
enableCommandBlocks="true"
viewDistance="20"
allowNether="true"
bungeeServerName="randomized"
serverAddress="192.168.1.111:25579"
serverMOTD="Randomized Drops World"
serverRestricted="true"
connectionThrottle="-1"
bungeeMode="true"

echo "*****************************************************************"
echo "Variables:"
echo "pteroVolumes: $pteroVolumes"
echo "fullServerPath: $pteroVolumes$serverPath"
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
echo "datapackRepo: $datapackRepo"
echo "randomDP: $randomDP"
echo "newDataPack: $newDataPack"
echo "worldFolder: $worldFolder"
echo "datapackFolder: $datapackFolder"
echo "connectionThrottle: $connectionThrottle"
echo "bungeeMode: $bungeeMode"
echo "bukkit: $bukkit" 
echo "spigot: $spigot" 
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

echo "Updating bukkit.yml $bukkit"
sed -i "s/^\(.*connection-throttle:\s\).*$/\1$connectionThrottle/" $bukkit;

echo "Updating spigot.yml $spigot"
sed -i "s/^\(.*bungeecord:\s\).*$/\1$bungeeMode/" $spigot;

echo "Resetting world and randomized DP..."
echo "removing $worldFolder now..."
rm -rf $worldFolder

echo "creating datapacks folder in world..."
mkdir -p $datapackFolder

echo "copying data pack into $datapackFolder"
cp $randomDP $datapackFolder
