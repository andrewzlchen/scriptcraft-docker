#!/bin/sh

MC_DIR=$HOME/spigotmc

if [ ! -d $MC_DIR ]
then
# make a new directory for spigotmc
mkdir $MC_DIR
fi

# ensure we're in the spigotmc folder
cd $MC_DIR

if [ ! -f $MC_DIR/BuildTools.jar || ! -f $HOME/BuildTools.jar ]
then
# get latest spigotmc jar file
wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
fi

if [ ! -d $MC_DIR/plugins ] 
then
echo "Building spigotmc directory..."
# run build tools to create the spigot mc server. Allocate enough memory to create the server
java -jar -Xmx1024M BuildTools.jar
java -jar spigot*.jar
fi

if [ ! -f $MC_DIR/eula.txt ]
then
# run the server. It will stop and require you to set eula agreement to true
java -jar spigot*.jar
fi

# agree to eula statement
echo "Agreeing to EULA agreement..."
sed -i 's/false/TRUE/g' $MC_DIR/eula.txt

# turn loading the 'end' map off
sed -i '.yaml' 's+allow-end: false+allow-end: true+g' $MC_DIR/bukkit.yml

# Now, we install scriptcraft

if [ ! -f $MC_DIR/plugins/scriptcraft.jar ]
then

mkdir $MC_DIR/plugins

# go to plugins folder
cd $MC_DIR/plugins

# download jar
wget https://github.com/walterhiggins/ScriptCraft/releases/download/3.4.0/scriptcraft.jar
fi

# at this point, the server is ready for development
