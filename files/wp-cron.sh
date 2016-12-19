#!/bin/sh

echo "1 * * * * /usr/bin/php -q /www/public/wp-cron.php >/dev/null 2>&1" | crontab -u www-data -
crond -b -d 8