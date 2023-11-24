
FROM debian:buster

RUN apt -y update && apt -y upgrade
RUN apt install -y  wget \
                    vim \
                    php-fpm \
                    php-mysql \
					sendmail \
                    mariadb-client

COPY ./tools/wordpress.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/wordpress.sh"]
CMD ["php-fpm7.3", "-F"]
