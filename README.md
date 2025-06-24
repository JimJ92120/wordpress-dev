# wordpress-dev

A minimal **WordPress** environment for development (do not use for **production**) with `docker`.  
`wp-cli` and `composer` are used to improve development experience (manage depedencies, scaffold resources, database management, etc).

---

---

# setup

| requirements |           |
| ------------ | --------- |
| `composer`   | `^2.8.5`  |
| `docker`     | `^27.5.1` |

### install

1. copy `.env.example` as `.env` and edit variables
2. install `composer` dependencies via `composer install`
3. build and run `docker` containers via `docker-compose up`
4. setup `wordpress` at `localhost:${WORDPRESS_PORT}`

### containers

Following containers will be created:

- `wordpress`: `wordpress` instance
- `wordpress-nginx`: `nginx` reverse-proxy to server `fpm` content
- `wordpress-cli`: `wp-cli` utils (see `wp-cli` section below)
- `wordpress-database`: `mysql` database
- `wordpress-phpmyadmin`: `phpmyadmin`
- `wordpress-mail-server`: `mailhog` SMTP server

### directory structure

`./wp-content` directory will be mounted as a `docker` volume.

`wp-cli` to e.g **scaffold** plugins will target directions located in `./wp-content`.

### wordpress plugins and themes

Plugins and themes can be added (if available) to `composer.json`, using [`wpackagist`](https://wpackagist.org/).  
Resources will be installed into `./wp-content/plugins` and `./wp-content/themes` directories.

```json
{
  "require": {
    # plugins
    "wpackagist-plugin/duplicate-post": "^4.5",
    "wpackagist-plugin/query-monitor": "^3.17",
    "wpackagist-plugin/wordpress-seo": "^25.2",

    # themes
    "wpackagist-theme/twentytwentyfive": "^1.2"
  }
}
```

To install all plugins and themes, run:

```sh
composer install
```

# development

Project is set to run at `http://localhost:${WORDPRESS_PORT}` (see `.env`).  
Different version of e.g `php` and `wordpress` may be run, the current stack uses:

- `wordpress 6.8.1`
- `php 8.4`

### wp-cli

`wp-cli` can be used along by targetting the dedicated `wordpress-cli` container.

```sh
docker-compose run --rm wordpress-cli $COMMAND

# e.g to create a new plugin
docker-compose run --rm wordpress-cli scaffold plugin plugin-test
```

See [`wp-cli` documentation](https://developer.wordpress.org/cli/commands/).

### mailhog

A `mailhog` SMTP server is set through `wordpress-mail-server` container for testing purposes.  
It comes with a mandatory `wp-content/mu-plugins/mailhog.php` plugin, to allow the WordPress instance to redirect SMTP requests to `wordpress-mail-server` container.

---

---

# documentation and links

- [`wp-cli`](https://developer.wordpress.org/cli/commands/)
- [`wpackagist`](https://wpackagist.org/)

### docker images

- https://hub.docker.com/_/wordpress
- https://hub.docker.com/_/mariadb
- https://hub.docker.com/_/nginx
- https://hub.docker.com/r/mailhog/mailhog
- https://hub.docker.com/_/phpmyadmin
