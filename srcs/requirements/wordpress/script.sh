#!/bin/bash
cd /var/www/html
if [ ! -f wp-config.php ]; then
	echo "Creating wp-config.php"

	mariadb-admin ping \
		--protocol=tcp \
		--host=$WORDPRESS_DB_HOST -u $MARIADB_USER \
		--password=$MARIADB_PASSWORD \
		--wait 

	wp core download    --allow-root \
		--version='latest'

	wp config create    --allow-root \
		--dbname=$MARIADB_DATABASE \
		--dbuser=$MARIADB_USER \
		--dbpass=$MARIADB_PASSWORD \
		--dbhost=$WORDPRESS_DB_HOST

	wp core install     --allow-root \
		--skip-email \
		--url=$WP_URL \
		--title=$WP_TITLE \
		--admin_user=$WP_ADMIN \
		--admin_email=$WP_ADMIN_MAIL \
		--admin_password=$WP_ADMIN_PWD


	wp user create      --allow-root \
		--path=/var/www/html \
		$WP_USER $WP_USER_MAIL \
		--user_pass=$WP_USER_PWD
fi
#curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#chmod +x wp-cli.phar
#./wp-cli.phar core download --allow-root
#./wp-cli.phar config create --dbname=wordpress --dbuser=wpuser --dbpass=password --dbhost=mariadb --allow-root
#./wp-cli.phar core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root

php-fpm8.2 -F
