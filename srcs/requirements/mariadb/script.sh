#!/bin/bash
set -e

if [ ! -d "/var/lib/mysql/${MARIADB_DATABASE}" ]; then
  echo "Initializing MariaDB database..."

  cat > /etc/mysql/init.sql <<EOF
CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};
CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

  mysqld --user=mysql --bootstrap < /etc/mysql/init.sql
fi

echo "Starting MariaDB in foreground..."
exec mysqld_safe

