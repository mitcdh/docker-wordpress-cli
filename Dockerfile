FROM wordpress

MAINTAINER Mitchell Hewes <me@mitcdh.com>
ENV DEBIAN_FRONTEND noninteractive

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp

RUN apt-get update && \
    apt-get install -y sudo less zip && \
    apt-get clean all && \
    chmod 755 /usr/local/bin/wp && \
    rm /var/log/apt/* /var/log/alternatives.log /var/log/bootstrap.log /var/log/dpkg.log