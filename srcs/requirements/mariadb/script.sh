#!/bin/sh

set -e  # Exit immediately if a command exits with a non-zero status

if [ ! -d "/var/lib/mysql/mysql" ]; then
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

chown -R mysql:mysql /var/lib/mysql /run/mysqld /var/log/mysql

mysqld_safe &
pid="$!"
# Wait for MariaDB to be ready
until mysqladmin ping --silent; do
  echo "Waiting for MariaDB to be ready..."
  sleep 2
done

# Create the database and user, and grant privileges this goes into a init-db.sh
mysql -u root <<-EOSQL
  CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};
  CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
  GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';
  FLUSH PRIVILEGES;
EOSQL
echo "Done"
#exec mysqld_safe
wait $pid
