FROM php:7.3.12-cli-alpine

RUN apk add --no-cache freetype libpng libjpeg-turbo \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS freetype-dev libpng-dev libjpeg-turbo-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd exif \
    && docker-php-ext-enable gd exif \
    && apk del .build-deps

WORKDIR /app
