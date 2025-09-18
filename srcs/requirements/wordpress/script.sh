#!/bin/bash
set -e

cd /var/www/html

# Wait for MariaDB to be ready (replace with your env vars as needed)
until mariadb-admin ping --protocol=tcp --host=mariadb -u "$MDB_USER" --password="$MDB_USER_PWD" --wait 2>/dev/null; do
  echo "Waiting for MariaDB..."
  sleep 3
done

if [ ! -f wp-config.php ]; then
    echo "Creating wp-config.php and installing WordPress..."

    # Download WordPress
    wp core download --allow-root

    # Create wp-config.php
    wp config create --allow-root \
        --dbname="$MDB_NAME" \
        --dbuser="$MDB_USER" \
        --dbpass="$MDB_USER_PWD" \
        --dbhost="mariadb:3306"

    # Install WordPress
    wp core install --allow-root \
        --url="$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PWD" \
        --admin_email="$WP_ADMIN_MAIL" \
        --skip-email

    # Create additional WP user
    wp user create "$WP_USER" "$WP_USER_MAIL" --user_pass="$WP_USER_PWD" --role=author --allow-root

else
    echo "WordPress already installed, updating admin password..."

    # Update admin password to ensure it's set correctly
    wp user update "$WP_ADMIN" --user_pass="$WP_ADMIN_PWD" --allow-root
fi

# Start PHP-FPM in foreground
php-fpm8.2 -F

