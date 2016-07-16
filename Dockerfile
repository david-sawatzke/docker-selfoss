FROM php:5.6-apache
MAINTAINER David Sawatzke <david@sawatzke.de>

# selfoss requirements: mod-headers, mod-rewrite, gd
RUN a2enmod headers rewrite && \
    apt-get update && \
    apt-get install -y unzip libpng12-dev libpq-dev && \
    docker-php-ext-install gd mbstring pdo_pgsql pdo_mysql

ADD https://github.com/SSilence/selfoss/releases/download/2.15/selfoss-2.15.zip /tmp/
RUN unzip /tmp/selfoss-*.zip -d /var/www/html && \
    rm /tmp/selfoss-*.zip && \
    ln -s /var/www/html/data/config.ini /var/www/html && \
    chown -R www-data:www-data /var/www/html

# Extend maximum execution time, so /refresh does not time out
COPY php.ini /usr/local/etc/php/
COPY start.sh /
RUN chmod 500 /start.sh
VOLUME /var/www/html/data

CMD ["/start.sh"]
