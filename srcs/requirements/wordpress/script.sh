#!/bin/bash
set -e

cd /var/www/html

# Step 1: Download WordPress if not present
if [ ! -f wp-load.php ]; then
  echo "Downloading WordPress..."
  wp core download --path=/var/www/html --allow-root --version=latest
fi

# Step 2: Wait for MariaDB to be ready
echo "Waiting for MariaDB to be available..."
until mysqladmin ping -h"$WORDPRESS_DB_HOST" -u"$MARIADB_USER" -p"$MARIADB_PASSWORD" --silent; do
  sleep 2
done

# Step 3: Setup WordPress config and install if needed
if ! wp core is-installed --allow-root; then
  echo "Creating wp-config.php..."

  wp config create --allow-root \
    --dbname="$MARIADB_DATABASE" \
    --dbuser="$MARIADB_USER" \
    --dbpass="$MARIADB_PASSWORD" \
    --dbhost="$WORDPRESS_DB_HOST"

  echo "Installing WordPress..."
  wp core install --allow-root \
    --url="$WP_URL" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN" \
    --admin_email="$WP_ADMIN_MAIL" \
    --admin_password="$WP_ADMIN_PWD"

  echo "Creating additional user..."
  # Check if user exists before creating
  if ! wp user get "$WP_USER" --allow-root >/dev/null 2>&1; then
    wp user create "$WP_USER" "$WP_USER_MAIL" --user_pass="$WP_USER_PWD" --allow-root
  else
    echo "User $WP_USER already exists, skipping user creation."
  fi
else
  echo "WordPress is already installed."
fi

# Step 4: Start PHP-FPM
php-fpm8.2 -F

