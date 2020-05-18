# Backup your Nextcloud Snap instance
A bash script to easly backup your Nextcloud Snap configuration and Data.<br />
<br />
The script comes from the necessity to regurlarly schedule a backup for nextcloud.<br />
It use the utility provided by nextcloud:<br />
https://github.com/nextcloud/nextcloud-snap/wiki/How-to-backup-your-instance<br />
to backup the apps, database and configuration.<br />
In addition it use rsync for an incremental data backup, instead of copy everything by scratch every time.<br />
<br />

# How to use it
First you need to run the `firstrun.sh` script, choosing your data directory:<br />
`/var/snap/nextcloud/common #by default`<br />
<br />
 And your destination directory:<br />
`/path/of/nextcloud/backup`<br />
you would choose a path of a secondary disk mounted in your system.<br />
<br />
After you set up the variables you are good to run:<br />
`sudo snap_nextcloud_backup.sh`<br />
<br />
If everything goes well you can schedule it on crontab.<br />
<br />