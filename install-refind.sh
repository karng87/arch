#!/bin/bash

##### ip a
##### iwctl, or wifi-menu
# device list
# station wlan0 scan
# station wlan0 get-networks
# station wlan0 connent homeip
# passwd

##### timedatectl set-ntp true
##### lsblk
##### fdisk /dev/sda
# g (gpi)
# n (new) -> +500M
# t (type) -> select partision -> 1 (efi system)
# n (hda)
# n (swap)

##### mkfs.fat -F32 /dev/sda1
##### mffs.ext4 /dev/sda2
##### mkswap /dev/sda3; mkswapon /dev/sda3
##### mount /dev/sda2 /mnt
##### mkdir /mnt/boot
##### mount /dev/sda1 /mnt/boot
##### pacstrap /mnt base linux linux-firmware vim git
##### genfstab -U /mnt >> /mnt/etc/fstab
##### arch-chroot /mnt
# fallocate -l 2GB /swapfile (file allocate)
# chmod 600 /swapfile
# mkswap /swapfile
# swapon /swapfile
# vi /etc/fstab
## /swapfile none swap default 0 0


ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen # en_US.UTF8 UTF8
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
#echo "KEYMAP=ko" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:8755 | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S refind-efi efibootmgr networkmanager network-manager-applet wireless_tools dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers 

pacman -S avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups hplip alsa-utils pulseaudio xorg pavucontrol bash-completion openssh rsync reflector acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font

pacman -S --noconfirm xf86-video-intel
#pacman -S --noconfirm xf86-video-amdgpu
#pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

#########################
###### refind ###########
#########################

refind-install --usedefault /dev/sda1 --alldrivers
mkrlconf
cd /boot
vim refind_linux.conf
### delete 1 2 line and left last line
##### "Boot with minal options" "ro root=/dev/sda2"
cd EFI
cd BOOT
vi refind.conf
### search arch
### replace uuid with "root=/dev/sda1 ..."
###########################################

### grub ######
# grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
# grub-mkconfig -o /boot/grub/grub.cfg
###############

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid

useradd -mG wheel jkarng
echo jkarng:8755 | chpasswd

#usermod -aG wheel libvirt video audio tty input jkarng

echo "jkarng ALL=(ALL) ALL" >> /etc/sudoers.d/jkarng

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
