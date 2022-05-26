#!/usr/bin/env bash

# Utility script outputting the target filename of the artifact being built.
#
# Usage:
# sh artifact-name.sh --platform <chrome|firefox> --label <version-label>
scriptName="$(basename "$0")"

usage() {
  echo "Usage: $scriptName --platform <chrome|firefox>"
  echo
  echo "Utility script outputting the target filename of the artifact being built."
  exit 2
}

parse_args() {
  platform=""

  while :; do
    case "$1" in
    --platform)
      platform="$2"
      shift 2
      ;;
    -h | --help)
      usage
      ;;
    *)
      break
      ;;
    esac
  done
}

parse_args "$@"

echo "$(./node_modules/node-jq/bin/jq ".name" -r <./src/manifest.json | tr '[:upper:]' '[:lower:]' | tr ' ' '-').$platform"
