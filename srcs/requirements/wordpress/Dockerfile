FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    php8.2-fpm php8.2-mysqli curl unzip \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Download wp-cli globally
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

# Ensure /var/www/html is a directory (clear it if it exists)
RUN rm -rf /var/www/html && mkdir -p /var/www/html

# Copy the necessary files into the container
COPY wp-config.php /var/www/html/
COPY www.conf /etc/php/8.2/fpm/pool.d/
COPY script.sh /usr/local/bin/script.sh

# Make sure script.sh is executable
RUN chmod +x /usr/local/bin/script.sh

# Set working directory to /var/www/html
WORKDIR /var/www/html

CMD ["/usr/local/bin/script.sh"]

