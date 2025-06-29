#!/bin/bash

echo "setting up project..."
composer install

echo "installing custom modules custom modules..."
MODULE_PATH_LIST_TO_BUILD=(
  "wp-content/plugins/plugin-name"
  "wp-content/themes/theme-name"
)

for MODULE_PATH in $MODULE_PATH_LIST_TO_BUILD; do
  echo "building \"$MODULE_PATH\"";

  if [ -e "$MODULE_PATH/composer.json" ]; then
    echo "running \"composer install\" for $MODULE_PATH"

    composer install --working-dir=$MODULE_PATH
  fi

  if [ -e "$MODULE_PATH/package.json" ]; then
    echo "running \"npm install\" and \"npm run build\" for $MODULE_PATH"

    npm --prefix $MODULE_PATH install
  fi
done

echo "done"
