# docker build -f php.Dockerfile -t php-test:1.0 .
FROM php:fpm

ENV DB_PW=$DB_PW
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
WORKDIR /app
COPY code.php /app
