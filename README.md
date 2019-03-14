Drupal-apache
--------------------
Php 7.2.12 and Apache docker image optimized for Drupal 8 development

## Image tagging
The image is tagged here and in Docker hub follows the tagging of php: the first two numbers represent the PHP 
version(i.e. 7.2), the last number (the one used usually for bugs) represent some changes (bugs, improvements...) to the image.

# How use it
Is possible to use this image pulling it directly from the Docker hub and create a container:
```
docker run --name test \
    -p 8080:80 \
    -e HOSTNAME=my_host_name \
    -v ${PWD}/index.php:/var/www/html/docroot/index.php \
    -d burdastyletech/drupal-apache:7.2.1
```
After this command you should see the php info in your browser at [http://localhost:8080](http://localhost:8080)

## Buiding variables
|Variable | Meaning                               | default      |
|:---------|:---------------------------------------|:--------------|
|`BROWSERMOB_PROXY_VERSION`|                        |2.1.4|
|`CHROME_DRIVER_VERSION`   |                        |2.36|
|`AH_SITE_ENVIRONMENT`| environment                 |dev |

## Environment variables
|Variable | Meaning                               | default      |
|:---------|:---------------------------------------|:--------------|
|`HOSTNAME` |local hostname inside docker container  | localhost    |
|`BEHAT_PARAMS`|behat params to run behat tests |{"extensions" : {"Vanare\\BehatCucumberJsonFormatter\\Extension":{"outputDir":"/tmp"},"Behat\\MinkExtension" : {"base_url" : "http://localhost/","files_path":"/var/www/html/behat/sample_data","show_tmp_dir":"/tmp"}, "Drupal\\DrupalExtension" : {"drupal" : {"drupal_root" : "/var/www/html/docroot"}}}}|


## Xdebug
This image is thought to be used mostly in development environment, so XDebug is not enabled by default.

To enable/disable it go inside your container and run ```xdebug_off```or ```xdebug_on```:
```
docker exec -it test bash
xdebug_off
```

*Here an explanation about the problem for Mac Users.*
- [https://www.ashsmith.io/docker/get-xdebug-working-with-docker-for-mac/](https://www.ashsmith.io/docker/get-xdebug-working-with-docker-for-mac/)
- [https://gist.github.com/ralphschindler/535dc5916ccbd06f53c1b0ee5a868c93](https://gist.github.com/ralphschindler/535dc5916ccbd06f53c1b0ee5a868c93)


## Build a new image
If you prefer to build a new image just run:
```
docker image build -t {your/image/name}:{your/tag} .
```


