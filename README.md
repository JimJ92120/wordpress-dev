# wordpress-dev

A minimal **WordPress** environment for development (do not use for **production**) with `wp-env`.  
`wp-cli` and `composer` are used to improve development experience (manage depedencies, scaffold resources, database management, etc).

---

---

# setup

| requirements |            |
| ------------ | ---------- |
| `node`       | `^22.14.0` |
| `npm`        | `^10.9.2`  |
| `php`        | `^8.4`     |
| `composer`   | `^2.8.5`   |
| `wp-cli`     | `^2.1`     |
| `docker`     | `^27.5.1`  |

### install

```sh
npm install
```

### directory structure

`./wp-content` directory will be mounted as a `docker` volume for `wp-env` containers.  
`wp-cli` to e.g **scaffold** plugins will be added to `./wp-content` directory.

See `.wp-env.json` mappings:

```json
{
  "mappings": {
    "wp-content": "./wp-content"
  }
}
```

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

### wp-env

`wp-env` is used to run a **development** and **testing** local environments.  
A `npm` wrapper has been added, `wp-env` can be called with `npm run wp-env $COMMAND`

```sh
# start docker containers
npm run wp-env start

# apply wp-env.json updates to docker containers
npm run wp-env start --update

# reset all docker containers
npm run wp-env clean all
```

Default credentials are:

- username: `admin`
- password: `password`

Additional configurations can be added to `.wp-env.json`.  
See [`wp-env` documentation](https://developer.wordpress.org/block-editor/reference-guides/packages/packages-env/).

### wp-cli

`wp-cli` can be used along `wp-env` by targetting the relevant `*-cli` `docker` container.  
To find which container to target, run `docker ps` and copy the name of the `*-cli` container.

Then run `wp-cli` such as:

```sh
wp --ssh=docker:$DOCKER_CLI_CONTAINER $COMMAND

# e.g with container "e390f3eaa02692d1e26c33d3b37b8e81-cli-1"
wp --ssh=docker:e390f3eaa02692d1e26c33d3b37b8e81-cli-1 scaffold plugin plugin-test
```

See [`wp-cli` documentation](https://developer.wordpress.org/cli/commands/).

###

---

---

# documentation and links

- [`wp-env`](https://developer.wordpress.org/block-editor/reference-guides/packages/packages-env/)
- [`wp-cli`](https://developer.wordpress.org/cli/commands/)
- [`wpackagist`](https://wpackagist.org/)
