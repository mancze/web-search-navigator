#!/usr/bin/env bash

##
# This script builds the extension for the Chrome browser.
#
##
echo 'Building Web Search Navigator for Chrome'
scriptDir="$(dirname "$0")"

# copy the sources into the working directory

bin=./build/chrome
obj="$bin/obj"
echo 'Copying files...'

# cleanup the previous build
rm -rf "$obj"
mkdir -p "$obj"

cp -R ./src/* "$obj"

echo 'Determining version'
version="$(sh "$scriptDir/version.sh" 'SNAPSHOT')"
echo "$version"

basename="$(sh "$scriptDir/artifact-name.sh" --platform "chrome")"

echo 'Creating package...'
zip -FSj "$bin/$basename-$version.zip" $obj/*

echo 'Build complete'
