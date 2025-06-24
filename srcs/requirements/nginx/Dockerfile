FROM debian:11

RUN apt update && apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl && \
	openssl req -x509 -nodes \
	-out /etc/nginx/ssl/amaula.42.fr.crt \
	-keyout /etc/nginx/ssl/amaula.42.fr.key \
	-subj "/C=FI/ST=UUSIMA/L=HELSINKI/O=HIVE/OU=HIVE/CN=amaula.42.fr"

COPY nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
