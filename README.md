# gw-rpi-install-script.sh

This script will install everything needed for flashing a 2020 Super Mario Game & Watch on a Raspberry Pi.
All that is needed is a clean Raspberry Pi OS (previously Rasbian) install on your Raspberry Pi.
 
You can run the script directly on the Raspberry Pi or via SSH if you have a headless setup.

If you plan on running the Raspberry Pi without a monitor and keyboard you can simply add a file called "ssh" to the root
of the SD-card after you are done flashing the Raspberry Pi OS image to it with your computer, this will make the
Raspberry Pi to activate ssh on the first boot.

Make the script executable with "chmod +x gw-rpi-install-script.sh" and start it with ". gw-rpi-install-script.sh"
Do NOT start it with "./" since that will make some of the variables not saved in the current session!
 
The last thing this script does is to run the game-and-watch-backup sanity check script, after that  you will have to follow
the guides on https://github.com/ghidraninja/game-and-watch-backup

This script is based on a guide made by Test232 found at https://drive.google.com/file/d/1kGac4ohnkP8rjvv0B2MbsQpdZBbfyIty/view

Thanks to kbeckmann, cyanic, DNA64 and the other people on the stacksmashing Discord for helping me to understand how the 
excellent software made by them and stacksmashing works.
