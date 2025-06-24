FROM alpine:latest

WORKDIR /app
VOLUME /app

RUN apk add --update mysql mysql-client && rm -f /var/cache/apk/*

COPY my.cnf /etc/my.cnf.d/my.cnf
COPY start.sh /start.sh

EXPOSE 3306

CMD ["/start.sh"]
