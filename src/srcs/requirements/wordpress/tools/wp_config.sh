#!/bin/sh

# Wait for MySQL to start
while ! mariadb -h$MYSQL_HOST -u$WP_DATABASE_USR -p$WP_DATABASE_PWD $WP_DATABASE_NAME &>/dev/null; do
    sleep 3
done

# Move index.html if it doesn't exist
if [ ! -f "/var/www/html/index.html" ]; then
    mv /tmp/index.html /var/www/html/index.html
fi

# Move style.css if it doesn't exist
if [ ! -f "/var/www/html/style.css" ]; then
    mv /tmp/style.css /var/www/html/style.css
fi

# Move mediaqueries.css if it doesn't exist
if [ ! -f "/var/www/html/mediaqueries.css" ]; then
    mv /tmp/mediaqueries.css /var/www/html/mediaqueries.css
fi

# Move script.js if it doesn't exist
if [ ! -f "/var/www/html/script.js" ]; then
    mv /tmp/script.js /var/www/html/script.js
fi

# Move assets directory if it doesn't exist
if [ ! -d "/var/www/html/assets" ]; then
    mv /tmp/assets /var/www/html/assets
fi

# Check if WordPress is already installed
if [ ! -f "/var/www/html/wordpress/wp-config.php" ]; then
    echo "Installing WordPress..."

    # Download WordPress core files
    wp core download --allow-root

    # Create the wp-config.php file with the database credentials
    wp config create --dbname=$WP_DATABASE_NAME \
                     --dbuser=$WP_DATABASE_USR \
                     --dbpass=$WP_DATABASE_PWD \
                     --dbhost=$MYSQL_HOST \
                     --allow-root

    # Install WordPress with the specified settings
    wp core install --url=$WP_URL/wordpress \
                    --title=$WP_TITLE \
                    --admin_user=$WP_ADMIN_USR \
                    --admin_password=$WP_ADMIN_PWD \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --skip-email \
                    --allow-root

    # Create a new WordPress user with the specified role and password
    wp user create $WP_USER_USR $WP_USER_EMAIL \
                   --role=author \
                   --user_pass=$WP_USER_PWD \
                   --allow-root
else
    echo "WordPress is already installed."
fi

# Start PHP-FPM
/usr/sbin/php-fpm81 -F -R