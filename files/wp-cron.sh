#!/bin/sh

while true;
do
	php /www/public/wp-cron.php > /dev/null 2>&1
	sleep 300
done

