# ip a
## iwctl
    device list
    station wlan0 scan
    station wlan0 get-networks
    station wlan0 connent homeip
        passwd

# timedatectl set-ntp true

## lsblk -f
## mkfs
    mkfs.vfat /dev/sda1
    mkswap /dev/sda2
    swapon /dev/sda2
    mkfs.ext4 /dev/sda3
    mkfs.ext4 /dev/sda4
## mount
    mount /dev/sda3 /mnt

    mkdir -p /mnt/boot/efi
    mkdir /mnt/home

    mount /dev/sda1 /mnt/boot/efi
    mount /dev/sda4 /mnt/home
    
## pacstrap /mnt
    pacstrap /mnt base linux linux-firmware git vim intel-ucode

## genfstab -U /mnt >> /mnt/etc/fstab
## arch-chroot /mnt

### git clone https:://gitlab.com/efilinux/arch-install-base
    cd arch-linux-base
    nvim bash.sh
        root:passwd

## after isntall
>  nmtui

## brightness
> xrandr --output eDP1 --brightness .5

## optimus-manager
> paru -S optimus-manager
>> reboot
>> optimus-manager --switch nvidia
>> optimus-manager --switch integrated 
>> optimus-manager --switch hybrid
