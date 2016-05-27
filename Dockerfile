FROM php:7.0.6-fpm

COPY config/custom.ini /usr/local/etc/php/conf.d/

RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev libpq-dev libmemcached-dev git \
    && docker-php-ext-install opcache \
    && docker-php-ext-install intl \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install mcrypt \
    ## APCu
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && cd /tmp \
    && git clone https://github.com/php-memcached-dev/php-memcached.git \ 
    && cd php-memcached \
    && git checkout php7
    && phpize \
    && ./configure --disable-memcached-sasl \
    && make \
    && make install
