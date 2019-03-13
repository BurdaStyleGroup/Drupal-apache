#!/usr/bin/env bash
set -e

echo ${HOSTNAME}
echo "127.0.0.1     ${HOSTNAME}" >> /etc/hosts;
export BEHAT_PARAMS='{"extensions" : {"Vanare\\BehatCucumberJsonFormatter\\Extension":{"outputDir":"/tmp"},"Behat\\MinkExtension" : {"base_url" : "http://${HOSTNAME}/","files_path":"/var/www/html/behat/sample_data","show_tmp_dir":"/tmp"}, "Drupal\\DrupalExtension" : {"drupal" : {"drupal_root" : "/var/www/html/docroot"}}}}';