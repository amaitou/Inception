#!/bin/bash

wget https://www.adminer.org/latest.php

mv latest.php adminer.php
mv adminer.php /var/www/html/

cd /var/www/html/

sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 8080/g' /etc/php/7.3/fpm/pool.d/www.conf

php -S 0.0.0.0:8080