FROM alpine:3.19.4

# Install dependencies
RUN apk update && apk upgrade && \
    apk add --no-cache wget tar mariadb-client && \
    apk add --no-cache php81 php81-fpm php81-opcache php81-gd php81-mysqli php81-zlib php81-curl \
    php81-mbstring php81-json php81-session php81-phar php81-cli php81-openssl php81-xml php81-tokenizer \
    php81-xmlwriter php81-simplexml php81-fileinfo php81-xmlreader php81-dom php81-ctype php81-iconv \
    php81-soap php81-sockets php81-ldap php81-pear php81-exif php81-ftp php81-gettext && \
    ln -s /usr/bin/php81 /usr/bin/php && \
    rm -rf /var/cache/apk/*

# PHP-FPM configuration
RUN adduser -S -G www-data www-data
COPY conf/php-fpm.conf /etc/php81/php-fpm.conf
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

# Copy static files for testing
COPY conf/index.html /tmp/index.html
COPY conf/style.css /tmp/style.css
COPY conf/mediaqueries.css /tmp/mediaqueries.css
COPY conf/script.js /tmp/script.js
COPY conf/assets /tmp/assets

# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/bin/wp

# Set the working directory for WordPress
WORKDIR /var/www/html

# Copy the configuration script
COPY tools/wp_config.sh /tmp/wp_config.sh
ENTRYPOINT ["sh", "/tmp/wp_config.sh"]

# Expose port 9000
EXPOSE 9000

# Start PHP-FPM in the foreground
CMD ["php-fpm81", "-F"]