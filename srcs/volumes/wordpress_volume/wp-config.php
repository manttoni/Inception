<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wpuser' );

/** Database password */
define( 'DB_PASSWORD', 'password' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          '#yU{eMS<oyn[@^Aq%3,s_,E{lnB8+5QS8x=AVFyA&u,JE_ft%6AU{.N}GyY.Wl+t' );
define( 'SECURE_AUTH_KEY',   'VhUs^9F9H-/Z<b=U3V0RtU|[,Mm:xxKg52O?A*@dk+cdNW_OQpyX)!G/=gu:2i~5' );
define( 'LOGGED_IN_KEY',     'EJuwY0m-CV+5)ZJ0PwL>M+0cLoZ2t<rFR/(O3|*+}|C[Ds78Vh^DGwGdcA,].%N`' );
define( 'NONCE_KEY',         '?qR ku(d6cZEbSJzEU*Csl>TDcoJhMzc0 }L=[Nc27Ty7ZhT&!V-_ S;qIP?314<' );
define( 'AUTH_SALT',         'g3[+_BLAD?3}_s{+hXKGlA6uaPF*;lF-0 [?<OFPcNXW-&6e.s=N`JNd*.!%KX;l' );
define( 'SECURE_AUTH_SALT',  'bJv~rq6Us$ 34- `=-,4<v3K&%{;e/71,^SMr$Aa+}+>oG>]yi(7y2V:_a-,2m=H' );
define( 'LOGGED_IN_SALT',    '-7yHZP&]H</`Cw20}STzONHT7MV}VA?xGi=,,#xx@YZc{I[=;XDk[kuQz[T-zbTW' );
define( 'NONCE_SALT',        ' 5Y.(Z:/8>_aqC|K>$9-dP%VA>*.-_E<3`0^o 6kV?eyOouGT!xk/;.j-)bv_SyQ' );
define( 'WP_CACHE_KEY_SALT', 'VnR;&cjV&DM>{$ot1+Jk~Wm80i]E8O&Ks3gG1Y/7Y:dohOY0_p=uF1_2hcuv2t_*' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
	define( 'WP_DEBUG', false );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
