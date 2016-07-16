#!/bin/sh

#Cheap cron replacement
sh -c "while true; do echo 'updating sources'; php /var/www/html/cliupdate.php; sleep 10m; done" &

exec apache2-foreground
