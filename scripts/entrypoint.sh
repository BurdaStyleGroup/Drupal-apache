#!/usr/bin/env bash
set -e

. /usr/local/bin/env_vars.sh

echo "127.0.0.1     ${HOSTNAME}" >> /etc/hosts;



# install self signed cert so chrome finds it
#echo QUIT | openssl s_client -connect ${HOSTNAME}:443 | sed -ne '/BEGIN CERT/,/END CERT/p' > ${HOSTNAME}.cert
#mkdir -p /var/www/html/docroot/.pki/nssdb
# we create a new nssdb and add our key
#certutil  --empty-password -d /var/www/html/docroot/.pki/nssdb -N
#certutil -d sql:/var/www/html/docroot/.pki/nssdb -A -t "P,," -n ${HOSTNAME} -i ${HOSTNAME}.cert
#certutil -L  -d sql:/var/www/html/docroot/.pki/nssdb
#chown -R vagrant:vagrant /var/www/html/docroot/.pki

apache2-foreground