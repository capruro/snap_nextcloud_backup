# Backup your Nextcloud Snap instance
A bash script to easly backup your Nextcloud Snap configuration and Data.

The script comes from the necessity to regurlarly schedule a backup for nextcloud.
It use the utility provided by nextcloud:
https://github.com/nextcloud/nextcloud-snap/wiki/How-to-backup-your-instance
to backup the apps, database and configuration.
In addition it use rsync for an incremental data backup, instead of copy everything by scratch every time.


# How to use it
First you need to edit the file, choosing your destination directory:
`DESTDIR=/path/of/backup/nextcloud`
you would choose a path of a secondary disk mounted in your system.

(OPTIONAL) In case you chose a different data directory for your Nextcloud instance you should also edit the variable:
`DATADIR=/var/snap/nextcloud/common #by default`

After you set up the variables you are good to run:
sudo snap_nextcloud_backup.sh

If everything goes well you can schedule it on crontab.
