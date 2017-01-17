FROM mitcdh/caddy-php
MAINTAINER Mitchell Hewes <me@mitcdh.com>

ENV WORDPRESS_VERSION 4.7.1
ENV WORDPRESS_SHA1 8e56ba56c10a3f245c616b13e46bd996f63793d6

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
COPY files/Caddyfile /caddy-bootstrap/Caddyfile
COPY files/wordpress.sh /caddy-bootstrap/pre-run/01_wordpress
COPY files/wp-cron.sh /caddy-bootstrap/pre-run/02_wp-cron

RUN apk --update add \
	php7-mysqli \
	zip \
	bash \
 && rm -rf /var/cache/apk/* \
 && chmod 755 /usr/local/bin/wp /caddy-bootstrap/pre-run/01_wordpress /caddy-bootstrap/pre-run/02_wp-cron \
 && set -x \
 && curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz" \
 && echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c - \
 && tar -xzf wordpress.tar.gz -C /www \
 && rm wordpress.tar.gz \
 && chown -R www-data:www-data /www/wordpress

VOLUME /www/public
EXPOSE 2015
