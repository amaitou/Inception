
FROM debian:buster

RUN apt -y update && apt -y upgrade
RUN apt install -y 	nginx \
			openssl \
			procps \
			vim
		

RUN mkdir -p /etc/nginx/snippets/
RUN mkdir -p /vat/run/nginx/

RUN chmod 755 /var/www/html/
RUN chown -R www-data:www-data /var/www/html/

EXPOSE 443

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
COPY ./tools/nginx.sh /usr/local/bin/

CMD ["/usr/local/bin/nginx.sh"]
