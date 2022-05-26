#!/usr/bin/env bash

##
# This script builds the extension for the Chrome browser.
#
##
echo 'Building Web Search Navigator for Chrome'
scriptDir="$(dirname "$0")"

# copy the sources into the working directory
BIN=./build/chrome
OBJ="$BIN/obj"
echo 'Copying files...'

# cleanup the previous build
rm -rf "$OBJ"
mkdir -p "$OBJ"

cp -R ./src/* "$OBJ"

echo 'Determining version'
version="$(sh "$scriptDir/version.sh" 'SNAPSHOT')"
echo "$version"

basename="$(sh "$scriptDir/artifact-name.sh" --platform "chrome")"

echo 'Creating package...'
zip -FSj "$BIN/$basename-$version.zip" $OBJ/*

echo 'Build complete'
