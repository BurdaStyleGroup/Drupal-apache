#!/usr/bin/env bash

firstChar=$(head -c 1 /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini)

if [[ ${firstChar} == "#" ]]; then
    echo "Xdebug already disabled";
else
    sed -i -e 's/^/#&/' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini;
     /etc/init.d/apache2 reload;
    echo "Xdebug is now disabled";
fi
