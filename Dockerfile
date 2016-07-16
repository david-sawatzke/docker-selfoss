FROM alpine
MAINTAINER David Sawatzke <david@sawatzke.de>

RUN apk add --no-cache \
      nginx \
      php-fpm \
      php-gd \
      php-cgi \
      php-pdo \
      php-json \
      php-zlib \
      php-xml \
      php-dom \
      php-curl \
      php-iconv \
      php-mcrypt \
      php-pdo_sqlite \
      php-ctype \
      libwebp \
      sqlite \
      ca-certificates \
      supervisor


# Extend maximum execution time, so /refresh does not time out
COPY php.ini /etc/php/
COPY nginx.conf /etc/nginx/nginx.conf
COPY php-fpm.conf /etc/php/php-fpm.conf
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY nginx.conf /etc/nginx/
COPY start.sh /
RUN chmod 500 /start.sh
VOLUME /selfoss/data

ENV SELFOSS_VERSION 2.15
RUN wget -O /tmp/selfoss.zip https://github.com/SSilence/selfoss/releases/download/$SELFOSS_VERSION/selfoss-$SELFOSS_VERSION.zip && \
    unzip /tmp/selfoss.zip -d /selfoss && \
    rm /tmp/selfoss.zip && \
    ln -s /selfoss/data/config.ini /selfoss && \
    chown -R nginx /selfoss && \
    sed -i -e 's/base_url=/base_url=\/./g' /selfoss/defaults.ini
CMD ["/start.sh"]
