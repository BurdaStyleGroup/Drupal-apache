#!/usr/bin/env bash
set -e

. /usr/local/bin/env_vars.sh

echo "127.0.0.1     ${HOSTNAME}" >> /etc/hosts;

apache2-foreground