#!/usr/bin/env bash

##
# This script builds the extension for the Chrome browser.
#
##
echo 'Building Web Search Navigator for Chrome'
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

# copy the sources into the working directory
BIN=./build/chrome
OBJ="$BIN/obj"
echo 'Copying files...'

# cleanup the previous build
rm -rf "$OBJ"
mkdir -p "$OBJ"

cp -R ./src/* "$OBJ"

echo 'Determining version'
VERSION="$(sh "$SCRIPT_DIR/version.sh" 'SNAPSHOT')"
echo "$VERSION"

echo 'Creating package...'
zip -FSj "$BIN/web_search_navigator.chrome-$VERSION.zip" $OBJ/*

echo 'Build complete'
