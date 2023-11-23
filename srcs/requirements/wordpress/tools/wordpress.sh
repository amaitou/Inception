#!/bin/bash

#if which wp > /dev/null/ 2>1; then
#	echo "[.] wp-cli is installed"
#else
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
#fi

mkdir -p /run/php/

if [ -e "/var/www/html/wordpress" ]; then
	echo "[.] /var/www/wordpress already created.";
else
	mkdir -p /var/www/html/wordpress/;
fi

cd /var/www/html/wordpress
rm -rf /var/www/html/wordpress/*

#if ! wp core is-installed; then
wp core download --allow-root
#fi

wp config create	--allow-root \
					--dbname=$DATABASE_NAME \
					--dbuser=$DATABASE_ROOT \
					--dbpass=$DATABASE_ROOT_PASSWORD \
					--dbhost=mariadb:3306 \
					--path='/var/www/html/wordpress'

wp core install		--allow-root \
					--url=$WORDPRESS_URL \
					--title=$WORDPRESS_TITLE \
					--admin_user=$WORDPRESS_ADMIN_USER \
					--admin_password=$WORDPRESS_ADMIN_PASSWORD \
					--admin_email=$WORDPRESS_ADMIN_EMAIL

#if wp user list --field=$DATABASE_SUB_USER --allow-root | grep -q "^$DATABASE_SUB_USER$"; then
#	echo "[.] user already created"
#else
wp user create	--allow-root \
				$WORDPRESS_SUB_USER \
				$WORDPRESS_SUB_EMAIL \
				--role=$WORDPRESS_SUB_ROLE \
				--user_pass=$WORDPRESS_SUB_PASSWORD
#fi

sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

exec "$@"
