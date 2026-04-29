FROM php:7.0-apache

RUN set -eux; \
    printf '%s\n' \
      'deb http://archive.debian.org/debian stretch main' \
      'deb http://archive.debian.org/debian-security stretch/updates main' \
      > /etc/apt/sources.list; \
    printf '%s\n' 'Acquire::Check-Valid-Until "false";' \
      > /etc/apt/apt.conf.d/99no-check-valid-until; \
    apt-get update; \
    apt-get install -y --allow-unauthenticated --no-install-recommends \
      ca-certificates \
      curl \
      wget \
      git \
      graphviz

RUN set -eux; \
    pecl channel-update pecl.php.net; \
    curl -fsSL https://github.com/xdebug/xdebug/archive/refs/tags/2.9.0.tar.gz -o /tmp/xdebug.tar.gz; \
    mkdir -p /usr/src/xdebug; \
    tar -xzf /tmp/xdebug.tar.gz -C /usr/src/xdebug --strip-components=1; \
    cd /usr/src/xdebug; \
    phpize; \
    ./configure && make && make install; \
    docker-php-ext-enable xdebug; \
    docker-php-ext-install pdo mysqli pdo_mysql

