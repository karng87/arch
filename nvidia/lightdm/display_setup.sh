#!/bin/sh
## edit /etc/lightdm/lightdm.conf
# "[Seat:*]
# display-setup-script=/etc/lightdm/display-setup-script.sh"

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

# reboot
