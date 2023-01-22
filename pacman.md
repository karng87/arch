scp -P 2222 dic root@localshot:/root 
pacman -y --refresh

# get info 
    apt list --installed
    apt list --upgradable

        pacman -Ss 
            from remote repository 
        pacman -Qs 
            from installed pkg
        pacamn -F /usr/bin/tree
            what from pacakge
    
# apt

### list
    apt list --installed
        pacman -Ss --query 
            from remote repository 
        pacman -Qs --query 
            from installed pkg
        pacamn -F /usr/bin/tree

### show
    apt show mpv
    pacman --query --info mpv

### edit
    apt edit-sources

### search
    apt search apt-fi*
        pacman -Qi(--query --info)
    
### install
        pacman -S(--sync)

### upate
        pacman -Syu (--refresh --upgrade)
    upgrade
    full-upgrade

### remove
        pacman -R(--remove)
    purge
    autoremov
        pacman -Scc(--clean --cache)
 ---

# cache dir
    /var/cache/pacman/pkg
    sed -En '1,20p' /etc/pacman.conf
# installed pkg database
    /var/lib/pacman/local
# syncronized pkg database
    /var/lib/pacman/local

# pacman -Sy
    sync remote repository to local pacakge db(/var/lib/pacman/sync)

