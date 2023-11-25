FROM debian:buster

RUN apt -y update && apt -y upgrade
RUN apt install -y  wget \
                    php \
                    php-mysql \
                    php-fpm

RUN mkdir -p /var/www/html/adminer/
RUN mkdir -p /run/php/

COPY ./tools/adminer.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/adminer.sh"]
CMD ["php-fpm7.3", "-F"]