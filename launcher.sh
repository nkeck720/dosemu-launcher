#!/bin/ksh
alias echo="echo -e"

#
# launchemu - a launcher for dosemu options
#

# define functions

dispconf () {
	clear
	echo "Display configuration"
	echo "---------------------"
	echo 
	echo "	1. Use X display"
	echo "	2. Use SDL display"
	echo "	3. Use default display"
	echo
	echo "Choose one: \c"
	read answer
	case $answer
	in
	     1) USE_X_DISPLAY=TRUE
	   	USE_SDL_DISPLAY=FALSE
	   	USE_DEFAULT_DISPLAY=FALSE;;
	     2) USE_X_DISPLAY=FALSE
	   	USE_SDL_DISPLAY=TRUE
		USE_DEFAULT_DISPLAY=FALSE;;
	     3) USE_X_DISPLAY=FALSE
	   	USE_SDL_DISPLAY=FALSE
	   	USE_DEFAULT_DISPLAY=TRUE;;
             *) echo "Bad choice"
	   	sleep 5;;
	esac
}

drivconf () {
	clear
	echo "Boot drive setup"
	echo "----------------"
	echo
	echo "	1. Boot from drive A"
	echo "	2. Boot from drive C"
	echo "	3. Boot from default drive"
	echo
	echo "Choose one: \c"
	read answer
	case $answer
	in
	     1) BOOT_A=TRUE
	   	BOOT_C=FALSE
	   	BOOT_DEFAULT=FALSE;;
	     2) BOOT_A=FALSE
	   	BOOT_C=TRUE
	   	BOOT_DEFAULT=FALSE;;
	     3) BOOT_A=FALSE
		BOOT_C=FALSE
	   	BOOT_DEFAULT=TRUE;;
	     *) echo "Bad choice"
	   	sleep 5;;
	esac
}

saveconf () {
	echo "Saving..."
	rm launcher.conf
	exec > launcher.conf
	echo "#"
	echo "# This .conf file contains the saved info from the dosemu launcher. Do not"
	echo "# edit this file unless absolutely necessary."
	echo "#"
	echo
	if [ "$BOOT_A" = "TRUE" ]
	then
		echo "BOOT_A=TRUE"
	elif [ "$BOOT_C" = "TRUE" ]
	then
		echo "BOOT_C=TRUE"
	else
		echo "BOOT_DEFAULT=TRUE"
	fi
	if [ "$USE_X_DISPLAY" = "TRUE" ]
	then
		echo "USE_X_DISPLAY=TRUE"
	elif [ "$USE_SDL_DISPLAY" = "TRUE" ]
	then
		echo "USE_SDL_DISPLAY=TRUE"
	else
		echo "USE_DEFAULT_DISPLAY=TRUE"
	fi
	echo "#"
	echo "# Do not edit past this point"
	echo "#"
	echo "export USE_X_DISPLAY USE_SDL_DISPLAY USE_DEFAULT_DISPLAY BOOT_A BOOT_C BOOT_DEFAULT"
	exec > /dev/tty
	chmod +x launcher.conf
	echo "Saved."
	sleep 3
}

dispsets () {
	clear
	echo "Current settings"
	echo "----------------"
	echo
	echo "Display type: \c"
	if [ "$USE_X_DISPLAY" = "TRUE" ]
	then
		echo "X window"
	elif [ "$USE_SDL_DISPLAY" = "TRUE" ]
	then
		echo "SDL window"
	else
		echo "DEFAULT"
	fi
	echo "Boot Drive: \c"
	if [ "$BOOT_A" = "TRUE" ]
	then
		echo "A: (/dev/fd0)"
	elif [ "$BOOT_C" = "TRUE" ]
	then
		echo "C: (usually FreeDos)"
	else
		echo "DEFAULT"
	fi
	echo
	echo "Press RETURN to continue"
	read answer
	answer=''
}

#
# launcher.conf is the main config file here. When a 'default' is referenced, it
# is the equivalent of running dosemu with no option specified.
#

#
# Get our options
#
while getopts rvn option
do
	case $option
	in
		r) runonly=TRUE;;
		v) veronly=TRUE;;
		n) nosave=TRUE;;
	       \?) echo "INTERNAL ERROR: BAD OPTS"
		   exit 1;;
	esac
done
#
# Load settings
#

if [ "$nosave" != "TRUE" ]
then
    . launcher.conf
fi 


if [ $veronly = "TRUE" ]
then
	echo "Version 1.0.0.56 alpha"
	exit 0
fi
	
# display the menu
while true
do
	if test $runonly = "TRUE" 
	then
		break
	fi
	clear
	echo "dosemu launcher menu                                                     Ver 1.0"
	echo "--------------------"
	echo
	echo "	1. Change boot drive"
	echo "	2. Change display configuration"
	echo "	3. Run dosemu"
	echo "	4. Save current settings for future use"
	echo "	5. View current settings"
	echo "	6. Exit this program"
	echo
	echo "Choose one: \c"
	read answer
	case $answer
	in
		1) drivconf;;
		2) dispconf;;
		3) break;;
		4) saveconf;;
		5) dispsets;;
		6) clear
		   exit 0;;
	esac
done

#
# Begin parsing options
#

cmdline="dosemu"
if [ "$BOOT_A" = "TRUE" ]
then
	cmdline="$cmdline -A"
elif [ "$BOOT_C" = "TRUE" ]
then
	cmdline="$cmdline -C"
fi
if [ "$USE_X_DISPLAY" = "TRUE" ]
then
	cmdline="$cmdline -X"
elif [ "$USE_SDL_DISPLAY" = "TRUE" ]
then
	cmdline="$cmdline -S"
fi
clear
#
# Kill this process and replace it with dosemu
#
exec $cmdline 
