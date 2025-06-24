#!/bin/sh

if [ -d /app/mysql ]; then
  echo "[i] MySQL directory already present, skipping creation"
else
  echo "[i] MySQL data directory not found, creating initial DBs"

  mariadb-install-db --user=root > /dev/null

  if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
  fi
fi

exec /usr/bin/mariadbd --user=root --console
