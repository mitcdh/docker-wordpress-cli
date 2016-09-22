FROM wordpress

MAINTAINER Mitchell Hewes <me@mitcdh.com>

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp

RUN chown www-data /usr/local/bin/wp && \
    chmod 4750 /usr/local/bin/wp