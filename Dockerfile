FROM mitcdh/caddy-php:php7
MAINTAINER Mitchell Hewes <me@mitcdh.com>

ENV WORDPRESS_VERSION 4.6.1
ENV WORDPRESS_SHA1 027e065d30a64720624a7404a1820e6c6fff1202

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
COPY files/Caddyfile /caddy-bootstrap/Caddyfile
COPY files/wordpress.sh /caddy-bootstrap/pre-run/01_wordpress
COPY files/wp-cron.sh /www/wp-cron.sh

RUN apk --update add \
	php7-mysqli \
	zip \
	bash \
 && rm -rf /var/cache/apk/* \
 && chmod 755 /usr/local/bin/wp /caddy-bootstrap/pre-run/01_wordpress /www/wp-cron.sh \
 && set -x \
 && curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz" \
 && echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c - \
 && tar -xzf wordpress.tar.gz -C /www \
 && rm wordpress.tar.gz \
 && chown -R www-data:www-data /www/wordpress

VOLUME /www/public
EXPOSE 2015