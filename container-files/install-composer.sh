#!/bin/sh
# Busybox environment

# fetch composer installer
EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
then
	echo 'ERROR: Invalid installer checksum' >&2 
	rm composer-setup.php
	exit 1
fi

# install composer
php composer-setup.php --quiet --2.2 --filename=composer --install-dir=/usr/local/bin
RESULT=$?
rm composer-setup.php
# exit on failure
[ $RESULT -eq 0 ] || exit $RESULT

# install dependencies
cd /app || exit 2
composer update -n --no-plugins --no-scripts --prefer-lowest
