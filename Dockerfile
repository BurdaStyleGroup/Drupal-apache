FROM php:7.2.12-apache

MAINTAINER Maurizio Brioschi <maurizio.brioschi@burda.com>

ARG BROWSERMOB_PROXY_VERSION=2.1.4
ARG CHROME_DRIVER_VERSION=2.36
ENV HOSTNAME=localhost
ENV BEHAT_PARAMS="{\"extensions\" : {\"Vanare\\BehatCucumberJsonFormatter\\Extension\":{\"outputDir\":\"/tmp\"},\"Behat\\MinkExtension\" : {\"base_url\" : \"http://localhost/\",\"files_path\":\"/var/www/html/behat/sample_data\",\"show_tmp_dir\":\"/tmp\"}, \"Drupal\\DrupalExtension\" : {\"drupal\" : {\"drupal_root\" : \"/var/www/html/docroot\"}}}}"

#ssl configuration
RUN sed -i -e 's/^#\(Include .*httpd-ssl.conf\)/\1/' \
        -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' \
        -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' \
        -e "\$aServerName localhost" \
        /etc/apache2/apache2.conf

RUN mkdir -p /var/www/html/docroot

#add scripts for enable/disable xdebug
ADD scripts/xdebug_on.sh /usr/local/bin/xdebug_on
ADD scripts/xdebug_off.sh /usr/local/bin/xdebug_off
#copy default configurations
COPY conf/php.ini /usr/local/etc/php/conf.d/php.ini
COPY conf/drupal.conf /etc/apache2/sites-available/000-default.conf
COPY conf/project.dev.crt /usr/local/share/ca-certificates/project.dev.crt
COPY conf/project.dev.pem /usr/local/share/ca-certificates/project.dev.pem
COPY conf/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

RUN apt-get update && apt-get install -y \
            software-properties-common \
    		libfreetype6-dev \
    		libjpeg62-turbo-dev \
    		libpng-dev \
    		libmemcached-dev zlib1g-dev \
    		mysql-client \
    		aptitude \
    		wget \
    		libusb-dev \
    		gnupg2 \
    		unzip \
    		libnss3-tools \
    	&& pecl install memcached-3.0.4 xdebug \
        && docker-php-ext-enable memcached  xdebug \
    	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    	&& docker-php-ext-install -j$(nproc) iconv  mysqli pdo pdo_mysql opcache gd \
    	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#install imagegick
RUN aptitude update && aptitude install -y imagemagick

#google-chrome-stable
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && apt-add-repository -y 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' \
    && apt-get update && apt-get install -y \
        google-chrome-stable
# Install ChromeDriver.
RUN wget -c -N http://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip -P /tmp \
    && unzip /tmp/chromedriver_linux64.zip -d /tmp/ \
    && rm /tmp/chromedriver_linux64.zip \
    && mv -f /tmp/chromedriver /usr/local/bin/chromedriver
# Install browsermob-proxy.
RUN wget https://github.com/lightbody/browsermob-proxy/releases/download/browsermob-proxy-${BROWSERMOB_PROXY_VERSION}/browsermob-proxy-${BROWSERMOB_PROXY_VERSION}-bin.zip -P /tmp \
    && unzip /tmp/browsermob-proxy-${BROWSERMOB_PROXY_VERSION}-bin.zip -d /tmp/ \
    && mv -f /tmp/browsermob-proxy-${BROWSERMOB_PROXY_VERSION} /usr/local/bin/browsermob-proxy

RUN a2enmod ssl rewrite \
    && xdebug_off   \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g amphtml-validator

COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY scripts/env_vars.sh /usr/local/bin/env_vars.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]


