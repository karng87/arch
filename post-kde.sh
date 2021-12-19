sudo pacman -S xf86-video-intel
#sudo pacman -S xf86-video-anmdgpu
#sudo pacman -S nvidia nvidia-utils

#sudo pacman -S xorg
sudo pacman -S sddm
#### gnome #####
# sudo pacman -S gdm
#### i3 ###
# sudo pacman -S lightdm

sudo systemctl enable sddm
#sudo systemctl enable gdm
#sudo systemctl enable lightdm

sudo pacman -S plasma kde-applications xdg-user-dirs packagekit-qt5

# sudo pacman -S gnmoe gnome-extra
# sudo apcman -S i3

reboot
