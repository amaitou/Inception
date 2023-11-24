FROM debian:buster

RUN apt -y update && apt -y upgrade
RUN apt install -y 	mariadb-server \
			vim \
			procps

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/mariadb.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]
CMD ["mysqld_safe"]
