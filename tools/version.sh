#!/usr/bin/env bash

# Utility script outputting the determined version of the extension
#
# Usage:
# sh version.sh <label>

suffix=""
if [ "$1" != "" ]; then
  suffix="-$1";
fi

echo "$(./node_modules/node-jq/bin/jq ".version" -r < ./src/manifest.json)$suffix"
