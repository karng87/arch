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
##### fdisk /dev/sdb
# g (gpi)
# n (new) -> +500M
# t (type) -> select partision -> 1 (efi system)
# n (hda)
# n (swap)

##### mkfs.fat -F32 /dev/sdb1
##### mffs.ext4 /dev/sdb2
##### mkswap /dev/sdb3; mkswapon /dev/sdb3
##### mount /dev/sdb2 /mnt
##### mkdir /mnt/boot
##### mount /dev/sdb1 /mnt/boot
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
sed -i '/^#en_US.UTF-8/s/.//' /etc/locale.gen # en_US.UTF8 UTF8
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
#echo "KEYMAP=ko" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

echo root:xxxx | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S refind networkmanager network-manager-applet wireless_tools dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers 

pacman -S avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils
pacman -S bluez bluez-utils cups hplip 
pacman -S alsa-utils pulseaudio pavucontrol bash-completion openssh rsync reflector acpi acpi_call tlp
pacman -S virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset
pacman -S firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font

pacman -S --noconfirm nvidia nvidia-utils nvidia-settings
#pacman -S xf86-video-intel
#pacman -S --noconfirm xf86-video-amdgpu

#########################
###### refind ###########
#########################

refind-install --usedefault /dev/nvme0n1p1--alldrivers
#refind-install --usedefault /dev/sdb1 --alldrivers

mkrlconf
sed -i '1,2d' /boot/refind_linux.conf
### delete 1 2 line and left last line
##### "Boot with minal options" "ro root=/dev/sdb2"
vim /boot/EFI/BOOT/refind.conf
### search arch
### replace uuid with "root=/dev/sdb1 ..."
# options  "root=PARTUUID=5028fa50-0079-4c40-b240-abfaf28693ea rw add_efi_memmap"
sed -E -i '/^menuentry "Arch Linux"/,/options/{/^ *options/s/=PARTUUID[^ ]+/=\/dev\/nvme0n1p1/}' /boot/EFI/BOOT/refind.conf
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
#systemctl enable firewalld
systemctl enable acpid

useradd -mG wheel jkarng
echo jkarng:passwd | chpasswd

usermod -aG wheel jkarng
usermod -aG libvirt jkarng
usermod -aG video jkarng
usermod -aG audio jkarng
usermod -aG tty jkarng
usermod -aG input jkarng

echo "jkarng ALL=(ALL) ALL" >> /etc/sudoers.d/jkarng
