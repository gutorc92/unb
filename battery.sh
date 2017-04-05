#!/bin/bash
upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -q "state.*discharging"
if [ "$?" -eq "0" ]; then
	echo "nao carregando"
	notify-send "Bateria" "A bateria nao ta carregando"	
fi

  
