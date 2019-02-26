Drupal-apache
--------------------
Php 7.2.12 and Apache docker image optimized for Drupal 8 development

# How use it
Is possible to use this image pulling it directly from the Docker hub and create a container:
```
docker run --name test \
    -p 8080:80 \
    -v ${PWD}/index.php:/var/www/html/docroot/index.php \
    -d burdastyletech/drupal-apache:0.9
```
After this command you should see the php info in your browser at [http://localhost:8080](http://localhost:8080)

## Build a new image
If you prefer to build a new image just run:
```
docker image build -t {your/image/name}:{your/tag} .
```

## Xdebug
This image is thought to be used mostly in development environment, so XDebug is enabled by default.
To disable it, go inside your container and run ```xdebug_off```or ```xdebug_on```:
```
docker exec -it test bash
xdebug_off
```
[Useful link](https://gist.github.com/ralphschindler/535dc5916ccbd06f53c1b0ee5a868c93)