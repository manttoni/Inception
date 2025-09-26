FROM debian:bookworm
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    php8.2-fpm php8.2-mysqli curl unzip \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/* && \
     curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

COPY www.conf /etc/php/8.2/fpm/pool.d/
COPY script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

WORKDIR /var/www/html

CMD ["/usr/local/bin/script.sh"]

