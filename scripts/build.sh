#!/bin/bash

ENV=$1
MODULE_PATH_LIST_TO_BUILD=(
  "wp-content/plugins/plugin-name"
  "wp-content/themes/theme-name"
)
MODULE_PATH_LIST_TO_REMOVE=(
  "wp-content/mu-plugins/mailhog.php"
)
BUILD_DIRECTORY=".build"

if [ -z $ENV ]; then
  echo "missing ENV argument"
  echo "e.g ./build.sh development"

  exit
fi

echo "building project $ENV..."

#
echo "building custom modules..."

for MODULE_PATH in ${MODULE_PATH_LIST_TO_BUILD[@]}; do
  echo "building \"$MODULE_PATH\"";

  if [ -e "$MODULE_PATH/package.json" ]; then
    npm --prefix $MODULE_PATH --loglevel=error run build
  fi
done

if [ "production" == $ENV ]; then
  echo "preparing build for $ENV..."

  for MODULE_PATH in ${MODULE_PATH_LIST_TO_BUILD[@]}; do
    echo "removing $MODULE_PATH..."

    rm -rf $MODULE_PATH
  done

  #
  rm -rf $BUILD_DIRECTORY
  mkdir $BUILD_DIRECTORY

  cp -r wp-content/mu-plugins wp-content/plugins wp-content/themes $BUILD_DIRECTORY
fi

#
echo "done"
