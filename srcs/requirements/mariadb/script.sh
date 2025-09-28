#!/bin/sh

set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

chown -R mysql:mysql /var/lib/mysql /run/mysqld /var/log/mysql

mysqld_safe --log-bin &
pid="$!"
# Wait for MariaDB to be ready
until mysqladmin ping --silent; do
  echo "Waiting for MariaDB to be ready..."
  sleep 2
done

mysql -u root <<-EOSQL
  CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};
  CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
  GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';
  FLUSH PRIVILEGES;
EOSQL
echo "Done"
wait $pid
