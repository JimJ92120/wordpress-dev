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


if [ "development" == $ENV ]; then
  for MODULE_PATH in ${MODULE_PATH_LIST_TO_BUILD[@]}; do
    echo "building \"$MODULE_PATH\"";

    if [ -e "$MODULE_PATH/package.json" ]; then
      npm --prefix $MODULE_PATH run build
    fi
  done
elif [ "production" == $ENV ]; then
  for MODULE_PATH in ${MODULE_PATH_LIST_TO_BUILD[@]}; do
    echo "building \"$MODULE_PATH\"";

    if [ -e "$MODULE_PATH/package.json" ]; then
      npm --prefix $MODULE_PATH --loglevel=error run build
      rm -rf $MODULE_PATH/node_modules
    fi
  done

  for MODULE_PATH in ${MODULE_PATH_LIST_TO_REMOVE[@]}; do
    echo "removing $MODULE_PATH..."

    rm -rf $MODULE_PATH
  done

  rm -rf $BUILD_DIRECTORY
  mkdir $BUILD_DIRECTORY
  mkdir "$BUILD_DIRECTORY/wp-content"

  cp -r wp-content/mu-plugins wp-content/plugins wp-content/themes $BUILD_DIRECTORY/wp-content
  ls $BUILD_DIRECTORY/wp-content/*
  du -hs .build
fi

#
echo "done"
