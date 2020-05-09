#!/bin/bash
# Backup for Nextcloud
#
## VARIABLES
DATADIR=/var/snap/nextcloud/common #by default
DESTDIR=/path/of/backup/nextcloud

## CONS
NAME=$(uname -n)
DATE=$(date +'%Y-%m-%d')
BCKDIR=/var/snap/nextcloud/common/backups

## SUB
info()
{
	echo "${NAME}|$(date +'%Y-%m-%d %H:%M:%S INFO: ')${@}" 1>&2
} # end info

info "Checking Backup destination"
if [[ -d $DESTDIR ]]
then
    info "Destination exist"
else
    info "Creating destination folder"
    mkdir -p $DESTDIR/snap
    chmod -r 700 $DESTDIR
fi


# backup Nextcloud
info "Backing up Snap folder"
nextcloud.export -abc
if [[ $? == 0 ]]
then
    LASTBCK=`ls -tr -1 $BCKDIR | tail -1`
    info "Archiving Snap confing backup"
    tar -zcvf $DESTDIR/snap/$LASTBCK\_nextcloud-backup.tar.gz $BCKDIR/$LASTBCK
    info "Removing temporary folder"
    rm -Rf $BCKDIR/$LAST
else
    info "Nextcloud export failed, exiting..."
    exit 1
fi

# backup Data
if [[ -d $DATADIR ]]
then
    cd $DATADIR
    info "Stopping Nextcloud"
    snap stop nextcloud
    info "Backing up Data folder"
    rsync -azP $DATADIR $DESTDIR
    info "Starting Nextcloud"
    snap start nextcloud
else
    info "Data Directory doesn't exist, exiting..."
    exit 1
fi

info "Backup Completed"
