#!/bin/bash
# Backup for Nextcloud
#
## VARIABLES
SNAPDIR=/var/snap/nextcloud/current/ #by default
DATADIR=/var/snap/nextcloud/common/ #by default
DESTDIR=/path/of/backup/nextcloud

## CONS
NAME=$(uname -n)
DATE=$(date +'%Y-%m-%d')

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

info "Stopping Nextcloud"
snap stop nextcloud

# backup Nextcloud
if [[ -d $SNAPDIR ]]
then
        cd $SNAPDIR
        info "Backing up Snap config folder"
        tar -zcvf $DESTDIR/snap/nextcloud.snap.backup-$DATE.tar.gz .
else
        info "Snap Directory doesn't exist, exiting..."
        exit 1
fi

# backup Data
if [[ -d $DATADIR ]]
then
        cd $DATADIR
        info "Backing up Data folder"
        rsync -Pour $DATADIR $DESTDIR
else
        info "Data Directory doesn't exist, exiting..."
        exit 1
fi

info "Starting Nextcloud"
snap start nextcloud
info "Backup Completed"
