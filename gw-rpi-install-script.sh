#!/bin/bash

# This script will install everything needed for flashing a 2020 Super Mario Game & Watch on a Raspberry Pi.

# All that is needed is a clean Raspberry Pi OS (previously Rasbian) install on your Raspberry Pi.
 
# You can run the script directly on the Raspberry Pi or via SSH if you have a headless setup.

# If you plan on running the Raspberry Pi without a monitor and keyboard you can simply add a file called "ssh" to the root
# of the SD-card after you are done flashing the Raspberry Pi OS image to it with your computer, this will make the
# Raspberry Pi to activate ssh on the first boot.

# Make the script executable with "chmod +x gw-rpi-install-script.sh" and start it with ". gw-rpi-install-script.sh"
# Do NOT start it with "./" since that will make some of the variables not saved in the current session!
# 
# The last thing this script does is to run the game-and-watch-backup sanity check script, after that  you will have to follow
# the guides on https://github.com/ghidraninja/game-and-watch-backup
#
# This script is based on a guide made by Test232 found at https://drive.google.com/file/d/1kGac4ohnkP8rjvv0B2MbsQpdZBbfyIty/view
#
# Thanks to kbeckmann, cyanic, DNA64 and the other people on the stacksmashing Discord for helping me to understand how the 
# excellent software made by them and stacksmashing works.


########################################################################################################################
# 1: sudo apt update
########################################################################################################################

echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)1: Running <apt update>$(tput sgr 0)" ; echo
sudo apt update

if [ $? -eq 0 ]
then
echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)<apt update> ok!$(tput sgr 0)"  ; echo

else

echo "$(tput setab 1)$(tput setaf 3)$(tput bold)$(tput smul)$(tput cuf 20)Something went wrong!$(tput sgr 0)" >&2
  exit 1

fi

########################################################################################################################
# 2: sudo apt upgrade -y
########################################################################################################################

echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)2: Running <apt upgrade>$(tput sgr 0)" ; echo
sudo apt upgrade -y

if [ $? -eq 0 ]
then
echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)<apt upgrade> ok!$(tput sgr 0)" ; echo
else

echo "$(tput setab 1)$(tput setaf 3)$(tput bold)$(tput smul)$(tput cuf 20)Something went wrong!$(tput sgr 0)"  >&2
  exit 1

fi

########################################################################################################################
# 3: sudo apt install -y binutils-arm-none-eabi python3 libftdi1 lz4 git npm
########################################################################################################################

echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)3: Installing neccecary utilities$(tput sgr 0)" ; echo
sudo apt install -y binutils-arm-none-eabi python3 libftdi1 lz4 git npm

if [ $? -eq 0 ]
then
echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)Utilities installed ok!$(tput sgr 0)" ; echo

else

echo "$(tput setab 1)$(tput setaf 3)$(tput bold)$(tput smul)$(tput cuf 20)Something went wrong!$(tput sgr 0)"  >&2
  exit 1

fi

########################################################################################################################
# 4: sudo npm install -y -global xpm@latest
########################################################################################################################

echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)4: Installing xpm$(tput sgr 0)" ; echo
sudo npm install -y -global xpm@latest

if [ $? -eq 0 ]
then
echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)xpm installed ok!$(tput sgr 0)" ; echo

else

echo "$(tput setab 1)$(tput setaf 3)$(tput bold)$(tput smul)$(tput cuf 20)Something went wrong!$(tput sgr 0)"  >&2
  exit 1

fi

########################################################################################################################
# 5: xpm install --global @xpack-dev-tools/openocd@latest
########################################################################################################################

echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)5: Installing openocd from xpack$(tput sgr 0)" ; echo
xpm install --global @xpack-dev-tools/openocd@latest

if [ $? -eq 0 ]
then
echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)Openocd from xpack installed ok!$(tput sgr 0)" ; echo

else

echo "$(tput setab 1)$(tput setaf 3)$(tput bold)$(tput smul)$(tput cuf 20)Something went wrong!$(tput sgr 0)"  >&2
  exit 1

fi

########################################################################################################################
# 6: Download arm-gcc
# mkdir -p ~/opt
# cd ~/opt
# wget https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/download/v10.2.1-1.1/xpack-arm-none-eabi-gcc-10.2.1-1.1-linux-arm.tar.gz
########################################################################################################################

echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)6: Downloading <xpack-none-eabiarm-gcc>$(tput sgr 0)" ; echo
mkdir -p ~/opt
cd ~/opt
wget https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/download/v10.2.1-1.1/xpack-arm-none-eabi-gcc-10.2.1-1.1-linux-arm.tar.gz

if [ $? -eq 0 ]
then
echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)<xpack-none-eabiarm-gcc> downloaded ok!$(tput sgr 0)" ; echo

else

echo "$(tput setab 1)$(tput setaf 3)$(tput bold)$(tput smul)$(tput cuf 20)Something went wrong!$(tput sgr 0)"  >&2
  exit 1

fi

########################################################################################################################
# 7: tar xvf xpack-arm-none-eabi-gcc-10.2.1-1.1-linux-arm.tar.gz xpack-arm-none-eabi-gcc-10.2.1-1.1 
########################################################################################################################

echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)7: Extracting <xpack-none-eabiarm-gcc>$(tput sgr 0)" ; echo
tar xvf xpack-arm-none-eabi-gcc-10.2.1-1.1-linux-arm.tar.gz xpack-arm-none-eabi-gcc-10.2.1-1.1 

if [ $? -eq 0 ]
then
echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)<xpack-none-eabiarm-gcc> extracted ok!$(tput sgr 0)" ; echo

else

echo "$(tput setab 1)$(tput setaf 3)$(tput bold)$(tput smul)$(tput cuf 20)Something went wrong!$(tput sgr 0)"  >&2
  exit 1

fi

########################################################################################################################
# 8: rm xpack-arm-none-eabi-gcc-10.2.1-1.1-linux-arm.tar.gz
########################################################################################################################

echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)8: Cleaning up after extraction$(tput sgr 0)" ; echo
rm xpack-arm-none-eabi-gcc-10.2.1-1.1-linux-arm.tar.gz

if [ $? -eq 0 ]
then
echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)Clean up ok!$(tput sgr 0)" ; echo

else

echo "$(tput setab 1)$(tput setaf 3)$(tput bold)$(tput smul)$(tput cuf 20)Something went wrong!$(tput sgr 0)"  >&2
  exit 1

fi

########################################################################################################################
# 9:
# export GCC_PATH=/home/pi/opt/xpack-arm-none-eabi-gcc-10.2.1-1.1/bin/
# export ADAPTER=rpi
# export adapter=rpi
# export OPENOCD=/home/pi/.local/xPacks/@xpack-dev-tools/openocd/0.11.0-2.1/.content/bin/openocd
########################################################################################################################

echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)9: Setting variables$(tput sgr 0)" ; echo
export GCC_PATH=/home/pi/opt/xpack-arm-none-eabi-gcc-10.2.1-1.1/bin/
export ADAPTER=rpi
export adapter=rpi
export OPENOCD=/home/pi/.local/xPacks/@xpack-dev-tools/openocd/0.11.0-2.1/.content/bin/openocd

if [ $? -eq 0 ]
then
echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)Variables set ok!$(tput sgr 0)" ; echo

else

echo "$(tput setab 1)$(tput setaf 3)$(tput bold)$(tput smul)$(tput cuf 20)Something went wrong!$(tput sgr 0)"  >&2
  exit 1

fi


########################################################################################################################
# 10:
# echo export GCC_PATH=/home/pi/opt/xpack-arm-none-eabi-gcc-10.2.1-1.1/bin/ >>~/.bashrc
# echo export ADAPTER=rpi >>~/.bashrc
# echo export adapter=rpi >>~/.bashrc
# echo export OPENOCD=/home/pi/.local/xPacks/@xpack-dev-tools/openocd/0.11.0-2.1/.content/bin/openocd >>~/.bashrc
########################################################################################################################

echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)10: Saving variables$(tput sgr 0)" ; echo
echo export GCC_PATH=/home/pi/opt/xpack-arm-none-eabi-gcc-10.2.1-1.1/bin/ >>~/.bashrc
echo export ADAPTER=rpi >>~/.bashrc
echo export adapter=rpi >>~/.bashrc
echo export OPENOCD=/home/pi/.local/xPacks/@xpack-dev-tools/openocd/0.11.0-2.1/.content/bin/openocd >>~/.bashrc

if [ $? -eq 0 ]
then
echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)Variables saved ok!$(tput sgr 0)" ; echo

else

echo "$(tput setab 1)$(tput setaf 3)$(tput bold)$(tput smul)$(tput cuf 20)Something went wrong!$(tput sgr 0)"  >&2
  exit 1

fi

########################################################################################################################
# 11:
# cd ~/opt
# git clone https://github.com/ghidraninja/game-and-watch-backup.git
########################################################################################################################

echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)11: Cloning <game-and-watch-backup>$(tput sgr 0)" ; echo
git clone https://github.com/ghidraninja/game-and-watch-backup.git

if [ $? -eq 0 ]
then
echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)<game-and-watch-backup> cloned ok!$(tput sgr 0)" ; echo

else

echo "$(tput setab 1)$(tput setaf 3)$(tput bold)$(tput smul)$(tput cuf 20)Something went wrong!$(tput sgr 0)"  >&2
  exit 1

fi

########################################################################################################################
# 12
# git clone https://github.com/ghidraninja/game-and-watch-flashloader.git
########################################################################################################################

echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)12: Cloning <game-and-watch-flashloader>$(tput sgr 0)" ; echo
git clone https://github.com/ghidraninja/game-and-watch-flashloader.git

if [ $? -eq 0 ]
then
echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)<game-and-watch-flashloader> cloned ok!$(tput sgr 0)" ; echo

else

echo "$(tput setab 1)$(tput setaf 3)$(tput bold)$(tput smul)$(tput cuf 20)Something went wrong!$(tput sgr 0)"  >&2
  exit 1

fi

########################################################################################################################
# 13 
# git clone --recurse-submodules https://github.com/kbeckmann/game-and-watch-retro-go
########################################################################################################################

echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)13: Cloning <game-and-watch-retro-go>$(tput sgr 0)" ; echo
git clone --recurse-submodules https://github.com/kbeckmann/game-and-watch-retro-go

if [ $? -eq 0 ]
then
echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)<game-and-watch-retro-go> cloned ok!$(tput sgr 0)" ; echo

else

echo "$(tput setab 1)$(tput setaf 3)$(tput bold)$(tput smul)$(tput cuf 20)Something went wrong!$(tput sgr 0)"  >&2
  exit 1

fi

########################################################################################################################
# 14
# cd ~/opt/game-and-watch-flashloader
# make
########################################################################################################################

echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)14: Compiling <game-and-watch-flashloader>$(tput sgr 0)" ; echo
cd ~/opt/game-and-watch-flashloader
make

if [ $? -eq 0 ]
then
echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)<game-and-watch-flashloader> compiled ok!$(tput sgr 0)" ; echo

else

echo "$(tput setab 1)$(tput setaf 3)$(tput bold)$(tput smul)$(tput cuf 20)Something went wrong!$(tput sgr 0)"  >&2
  exit 1

fi

########################################################################################################################
#15 
# cd ~/opt/game-and-watch-backup
# ./1_sanity_check.sh
########################################################################################################################

echo "$(tput setaf 5)$(tput bold)$(tput smul)$(tput cuf 20)15: Running <game-and-watch-backup> sanity check$(tput sgr 0)" ; echo
cd ~/opt/game-and-watch-backup/
./1_sanity_check.sh

if [ $? -eq 0 ]
then
echo "$(tput setaf 5)$(tput bold)$(tput smul)Everything installed and sanity check ok, your seem to be ready to start making a backup of your device!$(tput sgr 0)" ; echo

else

echo "$(tput setab 1)$(tput setaf 3)$(tput bold)$(tput smul)$(tput cuf 20)Something went wrong!$(tput sgr 0)"  >&2
  exit 1

fi
