#!/bin/bash
# Firstrun let you choose the target and destination directories
# it will create a new file in the local path
# in case the file already exist will be overwritten
#
## VARIABLES
FLAG=0

if [[ -d /var/snap/nextcloud/ ]]
then
else
    echo "You might want to snap install nextcloud first"
    exit 1
done

if [[ -f snap_nextcloud_backup.sh ]]
then
    echo "basic script exist"
else
    echo "basic script doens't exist, use git clone https://github.com/capruro/snap_nextcloud_backup.git"
    exit 1
fi

while [[ ${FLAG} -eq 0 ]]
do
    echo -n "Please select the Data folder: default [/var/snap/nextcloud/common]"
    read answer
    if [[ -d ${answer} ]]
    then
        echo "valid path"
        FLAG=1
        DATADIR=${answer}
    else    
        echo "Please enter a valid path"
        FLAG=0
    fi
done

#Flag reset
FLAG=0
while [[ ${FLAG} -eq 0 ]]
do
    echo -n "Please select the Destination folder:"
    read answer
    ls -ld ${answer}
    if [[ -d ${answer} ]]
    then
        echo "valid path"
        FLAG=1
        DESTDIR=${answer}
    else    
        echo "Please enter a valid path"
        FLAG=0
    fi
done

sed -i "s%^DATADIR=.*%DATADIR=${DATADIR}%" variables
sed -i "s%^DESTDIR=.*%DESTDIR=${DESTDIR}%" variables

echo "enjoy your nextcloud, stay safe with your backup"
echo "it's strongly recommended to schedule it in crontab"
