#!/bin/bash

# Start MariaDB in background
mysqld_safe &

# Wait for MariaDB socket to be ready (max 30 seconds)
timeout=30
while [ ! -S /run/mysqld/mysqld.sock ] && [ $timeout -gt 0 ]; do
  echo "Waiting for MariaDB to start..."
  sleep 1
  timeout=$((timeout - 1))
done

if [ $timeout -eq 0 ]; then
  echo "MariaDB did not start in time!"
  exit 1
fi

# Create init.sql dynamically
cat > /etc/mysql/init.sql <<EOF
CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};
CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Execute SQL commands
mysql -u root -p"${MARIADB_ROOT_PASSWORD}" < /etc/mysql/init.sql

# Keep container running
tail -f /dev/null

