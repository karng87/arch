sudo pacman -S tree-sitter texlive-most texlive-lang zathura
cd ~/Project
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

parun -S google-chrome

# fcitx5
sudo pacman -S fcitx5 fictx5-configtool libhangul fictx5-hangul fcitx5-gtk fcitx5-qt

vim /etc/environment
#    GTK_IM_MODULE=fcitx 
#    QT_IM_MODULE=fcitx 
#    XMODIFIERS=@im=fcitx

ficitx5-configtool
