#!/usr/bin/env bash

logfile='/var/log/screens_setup.log'
logdate=`date +%Y-%m-%d_%H:%M:%S`

screenconfig=''

while true
do
	nb_of_connected_screens=`xrandr|grep connected|grep -v disconnected|wc -l`
	nb_of_configured_screens=`xrandr|grep connected|grep -v disconnected|grep 1920|wc -l`
	# Not only laptop screen ?
	if [[ $nb_of_connected_screens > 1 ]]
	then
		# But just an another screen ?
		if [[ $nb_of_connected_screens < 3 ]]
		then
			if [[ $nb_of_configured_screens < 2 ]]
			then
				echo "$logdate - Configure screens : eDP-1 --auto --pos 0x0 --output DP-2-1 --auto --pos 1920x0" >> $logfile
				xrandr --output eDP-1 --auto --pos 0x0 --output DP-2-1 --auto --pos 1920x0
			fi
		# Two another screen ?
		elif [[ $nb_of_connected_screens == 3 ]]
		then
			if [[ $nb_of_configured_screens < 3 ]]
			then
				echo "$logdate - Configure screens : eDP-1 --auto --pos 0x0 --output DP-2-1 --auto --pos 1920x0 --output DP-2-2 --auto --pos 3840x0" >> $logfile
				xrandr --output eDP-1 --auto --pos 0x0 --output DP-2-1 --auto --pos 1920x0 --output DP-2-2 --auto --pos 3840x0
			fi
		fi
	fi
	sleep 5
done
