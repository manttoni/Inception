FROM debian:bookworm
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl && \
	openssl req -x509 -nodes \
	-out /etc/nginx/ssl/amaula.42.fr.crt \
	-keyout /etc/nginx/ssl/amaula.42.fr.key \
	-subj "/C=FI/ST=UUSIMA/L=HELSINKI/O=HIVE/OU=HIVE/CN=amaula.42.fr"

WORKDIR /etc/nginx/

COPY nginx.conf .

RUN adduser -D -H -s /sbin/nologin -g www-data -G www-data www-data

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
