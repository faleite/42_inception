# Code

## wp_config.sh
```sh
#!/bin/sh

# Wait for MySQL to start
while ! mariadb -h$MYSQL_HOST -u$WP_DATABASE_USR -p$WP_DATABASE_PWD $WP_DATABASE_NAME &>/dev/null; do
    sleep 3
done

if [ ! -f "/var/www/html/index.html" ]; then

	mv /tmp/index.html /var/www/html/index.html
	
	echo "Installing WordPress..."
	
	# # adminer
    # wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql-en.php -O /var/www/html/adminer.php &> /dev/null
    # wget https://raw.githubusercontent.com/Niyko/Hydra-Dark-Theme-for-Adminer/master/adminer.css -O /var/www/html/adminer.css &> /dev/null

	wp core download --allow-root
	wp config create --dbname=$WP_DATABASE_NAME \
					--dbuser=$WP_DATABASE_USR \
					--dbpass=$WP_DATABASE_PWD \
					--dbhost=$MYSQL_HOST \
					--allow-root
	wp core install --url=$WP_URL/wordpress \
					--title=$WP_TITLE --admin_user=$WP_ADMIN_USR \
					--admin_password=$WP_ADMIN_PWD \
					--admin_email=$WP_ADMIN_EMAIL \
					--skip-email --allow-root
	wp user create $WP_USER_USR $WP_USER_EMAIL \
					--role=author --user_pass=$WP_USER_PWD \
					--allow-root
	# wp theme install twentynineteen --activate --allow-root
fi

/usr/sbin/php-fpm81 -F -R
```