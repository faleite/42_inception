FROM alpine:3.19.4

# Install dependencies
RUN apk update && apk upgrade && \
    apk add --no-cache wget tar mariadb-client && \
    apk add --no-cache php81 php81-fpm php81-opcache php81-gd php81-mysqli php81-zlib php81-curl \
    php81-mbstring php81-json php81-session php81-phar php81-cli php81-openssl php81-xml php81-tokenizer \
    php81-xmlwriter php81-simplexml php81-fileinfo php81-xmlreader php81-dom php81-ctype php81-iconv \
    php81-soap php81-sockets php81-ldap php81-pear php81-exif php81-ftp php81-gettext && \
    rm -rf /var/cache/apk/*

# PHP-FPM configuration
RUN adduser -S nginx && addgroup -S nginx
COPY conf/php-fpm.conf /etc/php81/php-fpm.conf
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

# Copy a static HTML file for testing
COPY conf/index.html /tmp/index.html

# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/bin/wp

# Set the working directory for WordPress
WORKDIR /var/www/html/wordpress

# Copy the configuration script
COPY tools/wp_config.sh /tmp/wp_config.sh
ENTRYPOINT ["sh", "/tmp/wp_config.sh"]

# Expose port 9000
EXPOSE 9000

# Start PHP-FPM in the foreground
CMD ["/usr/sbin/php-fpm81", "-F"]