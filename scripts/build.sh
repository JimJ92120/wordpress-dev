#!/bin/bash

ENV=$1
MODULE_PATH_LIST_TO_BUILD=(
  "wp-content/plugins/plugin-name"
  "wp-content/themes/theme-name"
)

if [ -z $ENV ]; then
  echo "missing ENV argument"
  echo "e.g ./setup.sh development"

  exit
fi

echo "setting up project for $ENV..."

if [ "development" == $ENV ]; then
  composer install

  echo "installing custom modules custom modules..."

  for MODULE_PATH in ${MODULE_PATH_LIST_TO_BUILD[@]}; do
    echo "building \"$MODULE_PATH\"";

    if [ -e "$MODULE_PATH/composer.json" ]; then
      composer install --working-dir=$MODULE_PATH
    fi

    if [ -e "$MODULE_PATH/package.json" ]; then
      npm --prefix $MODULE_PATH install
    fi
  done
elif [ "production" == $ENV ]; then
  composer install --no-dev

  echo "installing custom modules custom modules..."

  for MODULE_PATH in ${MODULE_PATH_LIST_TO_BUILD[@]}; do
    echo "building \"$MODULE_PATH\"";

    if [ -e "$MODULE_PATH/composer.json" ]; then
      composer validate --strict
      composer install --working-dir=$MODULE_PATH --no-dev
    fi

    if [ -e "$MODULE_PATH/package.json" ]; then
      npm --prefix $MODULE_PATH --loglevel=error ci
    fi
  done
fi

echo "done"
