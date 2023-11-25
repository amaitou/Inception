#!/bin/bash

wget https://www.adminer.org/latest.php

mv latest.php adminer.php
mv adminer.php /var/www/html/adminer/

cd /var/www/html/adminer/

sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 0.0.0.0:8080/g' /etc/php/7.3/fpm/pool.d/www.conf

exec "$@"