#!/bin/bash
cd /var/www/html

# Check if wp-config.php exists, if not, create it
if [ ! -f wp-config.php ]; then
    echo "Creating wp-config.php"
	
    #echo "MARIADB_PASSWORD = $MARIADB_PASSWORD"
    #echo "WORDPRESS_DB_HOST = $WORDPRESS_DB_HOST"
    #echo "MARIADB_USER = $MARIADB_USER"
    #echo "MARIADB_DATABASE = $MARIADB_DATABASE"
    #echo "WORDPRESS_DB_HOST = $WORDPRESS_DB_HOST"
    #echo "WP_URL = $WP_URL"
    #echo "WP_TITLE = $WP_TITLE"
    #echo "WP_ADMIN = $WP_ADMIN"
    #echo "WP_ADMIN_MAIL = $WP_ADMIN_MAIL"
    #echo "WP_USER = $WP_USER"
    #echo "WP_USER_PWD = $WP_USER_PWD"
    # Wait for MariaDB to be ready
    mariadb-admin ping --protocol=tcp --host=$WORDPRESS_DB_HOST -u $MARIADB_USER --password=$MARIADB_PASSWORD --wait >/dev/null 2>/dev/null

    # Download WordPress if it's not already downloaded
    wp core download --allow-root --version='latest'

    # Create wp-config.php with the correct environment variables
    wp config create --allow-root \
                     --dbname=$MARIADB_DATABASE \
                     --dbuser=$MARIADB_USER \
                     --dbpass=$MARIADB_PASSWORD \
                     --dbhost=$WORDPRESS_DB_HOST

    # Install WordPress
    wp core install --allow-root \
                    --skip-email \
                    --url=$WP_URL \
                    --title=$WP_TITLE \
                    --admin_user=$WP_ADMIN \
                    --admin_email=$WP_ADMIN_MAIL \
                    --admin_password=$WP_ADMIN_PWD

    # Create WordPress user
    wp user create --allow-root \
                   --path=/var/www/html \
                   $WP_USER $WP_USER_MAIL \
                   --user_pass=$WP_USER_PWD
fi

# Start PHP-FPM (this keeps the container running)
php-fpm8.2 -F

