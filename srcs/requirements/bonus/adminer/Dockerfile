FROM debian:buster

RUN apt -y update && apt -y upgrade
RUN apt install -y  wget \
                    php \
                    php-mysql \
                    php-fpm

COPY ./tools/adminer.sh /usr/local/bin/

CMD ["/usr/local/bin/adminer.sh"]