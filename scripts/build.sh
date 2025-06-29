#!/bin/bash

echo "building project..."

#
echo "installing project..."
composer install --no-dev

#
echo "building custom modules..."
MODULE_PATH_LIST_TO_BUILD=(
  "wp-content/plugins/plugin-name"
  "wp-content/themes/theme-name"
)

for MODULE_PATH in $MODULE_PATH_LIST_TO_BUILD; do
  echo "building \"$MODULE_PATH\"";

  if [ -e "$MODULE_PATH/composer.json" ]; then
    echo "running \"composer install\" for $MODULE_PATH"

    composer install --working-dir=$MODULE_PATH --no-dev
  fi

  if [ -e "$MODULE_PATH/package.json" ]; then
    echo "running \"npm install\" and \"npm run build\" for $MODULE_PATH"

    npm --prefix $MODULE_PATH ci # --omit="dev"
    npm --prefix $MODULE_PATH run build
  fi
done

echo ""
echo "removing development modules"
MODULE_PATH_LIST_TO_REMOVE=(
  "wp-content/mu-plugins/mailhog.php"
)

for MODULE_PATH in $MODULE_PATH_LIST_TO_REMOVE; do
  echo $MODULE_PATH

  rm -rf $MODULE_PATH
done


#
BUILD_DIRECTORY=".build"

rm -rf $BUILD_DIRECTORY
mkdir $BUILD_DIRECTORY

cp -r wp-content/mu-plugins wp-content/plugins wp-content/themes $BUILD_DIRECTORY

#
echo "done"
