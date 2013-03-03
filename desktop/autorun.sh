#!/bin/sh
# starts from ~/.config/lxsession/LXDE/autostart

# language swith to CapsLock
setxkbmap -option grp:switch,grp:caps_toggle,grp_led:caps us,ru

# trackpoint speed for x220
sudo echo -n 120 > /sys/devices/platform/i8042/serio1/speed 
sudo echo -n 220 > /sys/devices/platform/i8042/serio1/sensitivity

~/bin/dropbox.py start
konsole
zenpad
google-chrome
keepassx
flush
