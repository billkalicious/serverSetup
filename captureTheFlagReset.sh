#!/bin/bash
# captureTheFlagReset.sh

# server guid
serverPath="53313a5b-a739-4771-9cfc-0b518517ad33"

# base vars
pluginRepo="/home/billkalicious/common_plugins_117"
pteroVolumes="/var/lib/pterodactyl/volumes/"
fullServerPath="$pteroVolumes$serverPath/"
pluginPath="${fullServerPath}plugins/"
newDataPack="$fullServerPath$datapackRepo$randomDP"
serverProperties="${fullServerPath}server.properties"
bukkit="${fullServerPath}bukkit.yml"
spigot="${fullServerPath}spigot.yml"
worldFolder="${fullServerPath}CTF1.17/"
worldBackupFolder="${fullServerPath}CTF1.17_bak/"

bungeeServerPath="${pteroVolumes}/a41bf189-6bea-46da-bafa-653a98d32fdc/"
bungeeConfig="${pteroVolumes}/a41bf189-6bea-46da-bafa-653a98d32fdc/config.yml"

# server specific vars
iamFile="${fullServerPath}_IAMCAPTURETHEFLAG"
gameMode="adventure"
levelName="cold_warfare"
pvp="true"
difficulty="normal"
onlineMode="false"
whiteList="false"
spawnNPCs="false"
spawnAnimals="false"
spawnMonsters="false"
spawnProtection="0"
enableCommandBlocks="true"
viewDistance="20"
allowNether="false"
bungeeServerName="capturetheflag"
serverAddress="192.168.1.111:25591"
serverMOTD="Capture the Flag!"
serverRestricted="true"
connectionThrottle="-1"
bungeeMode="true"
allowEnd="false"

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
echo "worldFolder: $worldFolder"
echo "connectionThrottle: $connectionThrottle"
echo "allowEnd: $allowEnd" 
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
sed -i "s/^\(.*allow-end:\s\).*$/\1$allowEnd/" $bukkit;

echo "Updating spigot.yml $spigot"
sed -i "s/^\(.*bungeecord:\s\).*$/\1$bungeeMode/" $spigot;

echo "Resetting world..."
echo "removing $worldFolder now..."
rm -rf $worldFolder

echo "copying world backup..."
cp -r $worldBackupFolder $worldFolder

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

