#!/bin/bash

sudo pacman -Sy

sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings i3 lxappearance nitrogen arandr picom rofi pcmanfm flatpak python-requests gnome-system-monitor pacman-contrib playerctl pavucontrol python-dbus dunst archlinux-wallpaper awesome-terminal-fonts ttf-font-awesome scrot 

sudo pacman -R --noconfirm i3lock

sudo systemctl enable lightdm

sudo reboot
