#!/usr/bin/env bash

#A simple script to loop over all our spec files and `npm run lint` on them

set -e

SCRIPT_DIR=$(dirname "$0")

#import shared list of spec files
source "$SCRIPT_DIR"/spec_files.sh

#make sure we're in the same dir as our package json so our paths work as expected
pushd "$(dirname "$0")"/../ >> /dev/null

#re-enable e flag so we don't stop running after first failed lint
set +e

for dir in $SPEC_FILES
do
  npm run lint "$dir/openapi.yaml"
done

set -e

#go back
popd >> /dev/null
