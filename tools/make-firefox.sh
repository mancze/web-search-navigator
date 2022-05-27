#!/usr/bin/env bash

# This script builds the extension for the Firefox browser.
#
# Usage:
# make-firefox --api-key <JWT issuer> --api-secret <JWT secret> [--id <{UUID}>]
#
# NOTE: Once the package at a given version is signed, the version number cannot
# be reused again.
#
# Requirements:
# - nodejs (current LTS version)
# - yarn
# - web-ext nodejs package (installed by default when you install project
#   dependencies with `yarn install`)

echo 'Building Web Search Navigator for Firefox'
scriptDir="$(dirname "$0")"

# copy the sources into the working directory
bin=build/firefox
obj="$bin/obj"
echo 'Copying files...'

# cleanup the previous build
rm -rf "$obj"
mkdir -p "$obj"

cp -R src/* "$obj"

# build and pack the package
echo 'Determining version'
version="$(sh "$scriptDir/version.sh" "SNAPSHOT")"
echo "$version"

basename="$(sh "$scriptDir/artifact-name.sh" --platform "firefox")"

# do not sign as it would result in signed add-on intended for self-distribution
echo 'Creating package...'
yarn run web-ext build --source-dir "$obj" --artifacts-dir "$bin" --filename "$basename.zip" "$@"

# web-ext converts filename lowercase
# apply the version string (with possible uppercase, e.g. SNAPSHOT) as a post-build step
mv "$bin/$basename.zip" "$bin/$basename-$version.zip"

echo 'Build complete'
