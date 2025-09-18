define('DB_NAME', getenv('MARIADB_DATABASE') ?: 'db');
define('DB_USER', getenv('MARIADB_USER') ?: 'uname');
define('DB_PASSWORD', getenv('MARIADB_PASSWORD') ?: 'password');
define('DB_HOST', getenv('WORDPRESS_DB_HOST') ?: 'mariadb:3306');

